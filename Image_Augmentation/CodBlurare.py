import tkinter as tk
from tkinter import filedialog
from PIL import Image, ImageTk, ImageFilter, ImageDraw
import os, random
import numpy as np
from skimage.filters import unsharp_mask

class BlurApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Aplicație de Filtre Imagine")
        self.root.attributes("-fullscreen", True)
        self.root.bind("<Escape>", lambda e: self.root.attributes("-fullscreen", False))

        self.img_original = None
        self.tk_img = None

        self.blur_mode = tk.StringVar(value="Gaussian")
        self.erase_mode = tk.StringVar(value="random")
        self.unsharp_percent = tk.DoubleVar(value=200)
        self.unsharp_radius = tk.DoubleVar(value=2)

        # --- Layout principal ---
        main_frame = tk.Frame(root, bg="#f3f3f3")
        main_frame.pack(fill="both", expand=True)

        # Imaginea în stânga
        self.image_label = tk.Label(main_frame, bg="#ddd")
        self.image_label.pack(side="left", expand=True, fill="both", padx=20, pady=20)

        # Panou lateral dreapta
        self.control_frame = tk.Frame(main_frame, bg="#ececec", bd=2, relief="groove")
        self.control_frame.pack(side="right", fill="y", padx=20, pady=20)

        # Buton de închidere
        exit_btn = tk.Button(self.control_frame, text="X", font=("Segoe UI", 11), width=4,
                             command=root.destroy, bg="#ff4d4d", fg="white")
        exit_btn.pack(anchor="ne", padx=5, pady=5)

        tk.Label(self.control_frame, text="Meniu principal", bg="#ececec",
                 font=("Segoe UI", 14, "bold")).pack(pady=(10, 15))

        tk.Button(self.control_frame, text="Alege Imaginea",
                  font=("Segoe UI", 11), width=22,
                  command=self.alege_imagine).pack(pady=5)

        tk.Button(self.control_frame, text="Random Erasing",
                  font=("Segoe UI", 11), width=22,
                  command=self.show_random_erasing_options).pack(pady=5)

        tk.Button(self.control_frame, text="Blur Filters",
                  font=("Segoe UI", 11), width=22,
                  command=lambda: self.show_filter_options("blur")).pack(pady=5)

        tk.Button(self.control_frame, text="Edge Enhancement",
                  font=("Segoe UI", 11), width=22,
                  command=lambda: self.show_filter_options("edge")).pack(pady=5)

        tk.Button(self.control_frame, text="Înapoi (Reset imagine)",
                  font=("Segoe UI", 11), width=22,
                  command=self.resetare).pack(pady=(30, 10))

        # Zona unde apar opțiunile filtrului și slider-ele
        self.option_frame = tk.Frame(self.control_frame, bg="#ececec")
        self.option_frame.pack(pady=5, fill="x")

        # Slider principal
        self.slider_label = tk.Label(self.option_frame, text="", bg="#ececec")
        self.slider_label.pack(pady=5)
        self.slider = tk.Scale(self.option_frame, from_=0, to=10, resolution=0.5,
                               orient="horizontal", variable=self.unsharp_radius,
                               command=self.aplica_filtru, length=180)
        self.slider.pack(pady=5)

        # Slider pentru Unsharp Mask
        self.unsharp_frame = tk.Frame(self.option_frame, bg="#ececec")
        tk.Label(self.unsharp_frame,
                 text="Amount (%) - Putere Accent (Skimage):",
                 bg="#ececec").pack(padx=5, pady=2, anchor="w")
        self.slider_percent = tk.Scale(self.unsharp_frame, from_=50, to=500,
                                       resolution=10, orient="horizontal",
                                       variable=self.unsharp_percent,
                                       command=self.aplica_filtru, length=180)
        self.slider_percent.pack(padx=10, pady=2)
        self.unsharp_frame.pack_forget()

        # Radio buttons pentru Random Erasing + buton Aplică
        self.erase_frame = tk.Frame(self.option_frame, bg="#ececec")
        tk.Label(self.erase_frame, text="Tip Zgomot:", bg="#ececec").pack(anchor="w")
        tk.Radiobutton(self.erase_frame, text="Random Pixels", variable=self.erase_mode,
                       value="random", bg="#ececec").pack(anchor="w")
        tk.Radiobutton(self.erase_frame, text="Gray Patch", variable=self.erase_mode,
                       value="gray", bg="#ececec").pack(anchor="w")
        self.apply_erase_btn = tk.Button(self.erase_frame, text="Aplică Random Erasing",
                                         command=self.random_erasing)
        self.apply_erase_btn.pack(pady=5)
        self.erase_frame.pack_forget()

        self.eticheta = tk.Label(self.option_frame, text="Așteaptă încărcarea imaginii...",
                                 bg="#ececec", wraplength=200)
        self.eticheta.pack(pady=10)

        # Imagine default
        cale_automata = os.path.expanduser("~/Downloads/close_up.jpeg")
        if os.path.exists(cale_automata):
            self.img_original = Image.open(cale_automata).convert("RGB")
            self.afiseaza(self.img_original)
        else:
            self.eticheta.config(
                text=f"Imaginea nu a fost găsită la: {cale_automata}")

    # --- Funcții ---
    def show_filter_options(self, category):
        self.erase_frame.pack_forget()
        self.unsharp_frame.pack_forget()
        self.slider_label.pack(pady=5)
        self.slider.pack(pady=5)

        for widget in self.option_frame.winfo_children():
            if widget not in [self.slider_label, self.slider, self.unsharp_frame, self.erase_frame, self.eticheta]:
                widget.pack_forget()

        if category == "blur":
            tk.Label(self.option_frame, text="Selectează tipul de Blur:", bg="#ececec").pack(pady=5)
            tk.Button(self.option_frame, text="Gaussian Blur", width=20,
                      command=lambda: self.set_filter("Gaussian")).pack(pady=2)
            tk.Button(self.option_frame, text="Box Blur", width=20,
                      command=lambda: self.set_filter("Box")).pack(pady=2)
        elif category == "edge":
            # Păstrăm doar Unsharp Mask
            tk.Label(self.option_frame, text="Selectează metoda:", bg="#ececec").pack(pady=5)
            tk.Button(self.option_frame, text="Unsharp Mask", width=20,
                      command=lambda: self.set_filter("UnsharpMask")).pack(pady=2)

    def show_random_erasing_options(self):
        self.unsharp_frame.pack_forget()
        self.slider_label.pack_forget()
        self.slider.pack_forget()
        for widget in self.option_frame.winfo_children():
            if widget not in [self.erase_frame, self.eticheta]:
                widget.pack_forget()
        self.erase_frame.pack(pady=5)

    def set_filter(self, value):
        self.blur_mode.set(value)
        self.update_controls()

    def resetare(self):
        if self.img_original:
            self.afiseaza(self.img_original)
        # Ascund toate opțiunile
        self.slider_label.pack_forget()
        self.slider.pack_forget()
        self.unsharp_frame.pack_forget()
        self.erase_frame.pack_forget()
        for widget in self.option_frame.winfo_children():
            if widget not in [self.eticheta]:
                widget.pack_forget()

    def alege_imagine(self):
        cale = filedialog.askopenfilename(title="Alege o imagine")
        if not cale:
            return
        try:
            self.img_original = Image.open(cale).convert("RGB")
            self.afiseaza(self.img_original)
        except Exception as e:
            self.eticheta.config(text=f"Eroare la încărcarea imaginii: {e}")

    def update_controls(self):
        mod_curent = self.blur_mode.get()
        if mod_curent in ["Gaussian", "Box"]:
            self.slider_label.config(text="Blur Radius (Rază estompare)")
            self.slider.config(to=10, resolution=0.5)
            self.unsharp_frame.pack_forget()
        elif mod_curent == "UnsharpMask":
            self.slider_label.config(text="Skimage Radius (0.1 - 5)")
            self.slider.config(to=5, resolution=0.1)
            self.unsharp_frame.pack(pady=5)
        self.aplica_filtru()

    def aplica_filtru(self, val=None):
        if self.img_original is None:
            return
        mod_curent = self.blur_mode.get()
        r = self.slider.get()
        img_filtrata = self.img_original.copy()
        if mod_curent == "UnsharpMask":
            amount = self.unsharp_percent.get() / 100.0
            img_np = np.array(self.img_original, dtype=np.float64) / 255.0
            im_sharpened_np = np.zeros_like(img_np)
            for i in range(img_np.shape[-1]):
                im_sharpened_np[..., i] = unsharp_mask(img_np[..., i], radius=r, amount=amount)
            im_sharpened_np = np.clip(im_sharpened_np * 255, 0, 255).astype(np.uint8)
            img_filtrata = Image.fromarray(im_sharpened_np)
        elif mod_curent == "Gaussian":
            img_filtrata = self.img_original.filter(ImageFilter.GaussianBlur(radius=r))
        elif mod_curent == "Box":
            img_filtrata = self.img_original.filter(ImageFilter.BoxBlur(radius=r))
        self.afiseaza(img_filtrata)

    def random_erasing(self):
        if self.img_original is None:
            return
        img_mod = self.img_original.copy()
        draw = ImageDraw.Draw(img_mod)
        W, H = img_mod.size
        S = W * H
        Se = random.uniform(0.02, 0.4) * S
        aspect_ratio = random.uniform(0.3, 1/0.3)
        He = int((Se * aspect_ratio) ** 0.5)
        We = int((Se / aspect_ratio) ** 0.5)
        xe = random.randint(0, W - We)
        ye = random.randint(0, H - He)
        x2, y2 = xe + We, ye + He
        mode = self.erase_mode.get()
        if mode == "random":
            for x in range(xe, x2):
                for y in range(ye, y2):
                    img_mod.putpixel((x, y),
                                     (random.randint(0, 255),
                                      random.randint(0, 255),
                                      random.randint(0, 255)))
        elif mode == "gray":
            mean_val = (125, 122, 114)
            draw.rectangle([xe, ye, x2, y2], fill=mean_val)
        self.afiseaza(img_mod)

    def afiseaza(self, img):
        max_dim = 900
        latime, inaltime = img.size
        if latime > inaltime:
            inaltime = int(inaltime * (max_dim / latime))
            latime = max_dim
        else:
            latime = int(latime * (max_dim / inaltime))
            inaltime = max_dim
        img_redim = img.resize((latime, inaltime))
        self.tk_img = ImageTk.PhotoImage(img_redim)
        self.image_label.config(image=self.tk_img)
        self.image_label.image = self.tk_img

if __name__ == '__main__':
    root = tk.Tk()
    app = BlurApp(root)
    root.mainloop()
