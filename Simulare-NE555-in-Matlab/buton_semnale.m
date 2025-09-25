%Gasire obiecte din figura dupa tag


fig=findobj(gcf,'Tag','fereastra');
    BR1=findobj(gcf,'Tag','rezistenta1');
r1=str2double(get(BR1,'String'));

 BR2=findobj(gcf,'Tag','rezistenta2');
r2=str2double(get(BR2,'String'));

 BP=findobj(gcf,'Tag','tensiune');
VCC=str2double(get(BP,'String'));
     if VCC > 15
    errordlg('Valoarea introdusă depășește limita permisă.Reveniti la partea de teorie.', 'Eroare');
    close(fig);
    return;
     end
     if VCC < 4.5
    errordlg('Valoarea introdusă depășește limita permisă.Reveniti la partea de teorie.', 'Eroare');
    close(fig);
    return;
     end
 BC=findobj(gcf,'Tag','condensator');
c=str2double(get(BC,'String'));
   
R1=r1*10^3;

R2=r2*10^3;

C=c*10^-6;


%Transformare unitati de masura pentru R1


Bk=findobj(gcf,'Tag','popu');
selectedOption = get(Bk, 'Value');

if selectedOption == 1
    R1 = r1;
elseif selectedOption == 2
    R1 = r1 * 10^3;
elseif selectedOption == 3
    R1 = r1 * 10^6;
else
    % Opțiune neașteptată
    disp('Unexpected selected option');
end
%Transformare unitati de masura pentru R2
BC=findobj(gcf,'Tag','popu2');
selectedOption2 = get(BC, 'Value');

if selectedOption2 == 1
    R2 = r2;
elseif selectedOption2 == 2
    R2 = r2 * 10^3;
elseif selectedOption2 == 3
    R2 = r2 * 10^6;
else
    % Opțiune neașteptată
    disp('Unexpected selected option');
end

BC=findobj(gcf,'Tag','popu3');
selectedOption3 = get(BC, 'Value');

%Transformare unitati de masura pentru Condensator

if selectedOption3 == 1
    C = c;
elseif selectedOption3 == 2
    C = c * 10^-3;
elseif selectedOption3 == 3
    C = c * 10^-6;
    elseif selectedOption3 == 4
   C = c * 10^-9;
else
    % Opțiune neașteptată
    disp('Unexpected selected option');
end
if z==1
    
 % Generarea semnalului OUTPUT
   T=0.7*(R1+2*R2)*C;
    f = 1.4/((R1+2*R2)*C);

    t_total = numar_perioade * T;
    t = linspace(0, t_total, 1000);
    r=1;
y_output = (sign(sin(r * 2*pi*f * (t + T / 4))) + 1) / 2;



%Afisare Duty-Cycle
    D = ((R1 + R2)/(R1 + 2*R2)) * 100;
    formattedD = sprintf('%.2f', D);

ju = uipanel("Units","normalized" ,...
      "Position",[0.35 0.6 0.15 0.3]);

uicontrol("Style","text",...
        "String","Duty-Cycle",...
        "Units","normalized",...
        "Position",[0.05 0.9 0.35 0.1],...
        "Parent",ju,...
        "Fontsize",14)

    uicontrol("Style","edit",...
        "String",formattedD,...
        "Units","normalized",...
        "Position",[0.55 0.9 0.15 0.1],...
        "Enable","off",...
        "Callback","buton_semnale",...
        "Parent",ju)

    uicontrol("Style","text",...
        "String","%",...
        "Units","normalized",...
        "Position",[0.7 0.9 0.1 0.1],...
        "Parent",ju,...
        "FontSize",14)


%afisare frecventa


uicontrol("Style","text",...
        "String","f",...
        "Units","normalized",...
        "Position",[0.05 0.7 0.35 0.1],...
        "Parent",ju,...
        "Fontsize",14)

    uicontrol("Style","edit",...
        "String",f,...
        "Units","normalized",...
        "Position",[0.55 0.7 0.15 0.1],...
        "Enable","off",...
        "Callback","buton_semnale",...
        "Parent",ju)

uicontrol("Style","text",...
        "String","Hz",...
        "Units","normalized",...
        "Position",[0.7 0.7 0.1 0.1],...
        "Parent",ju,...
        "FontSize",14)


  %afisare perioada
uicontrol("Style","text",...
        "String","Perioada",...
        "Units","normalized",...
        "Position",[0.05 0.50 0.35 0.1],...
        "Parent",ju,...
        "Fontsize",14)

    uicontrol("Style","edit",...
        "String",T,...
        "Units","normalized",...
        "Position",[0.55 0.50 0.15 0.1],...
        "Enable","off",...
        "Callback","buton_semnale",...
        "Parent",ju)

 uicontrol("Style","text",...
        "String","s",...
        "Units","normalized",...
        "Position",[0.7 0.5 0.1 0.1],...
        "Parent",ju,...
        "FontSize",14)

A=1;
 x = A * asin(sin(2 * pi * f * t)) / pi;  
componenta_continua = 1*VCC/6;  
y = x + componenta_continua;  
lower_limit = 1 / 3 * VCC;
upper_limit = 2 / 3 * VCC;
y_scaled = (y - min(y)) / (max(y) - min(y)) * (upper_limit - lower_limit) + lower_limit;

      % Afisarea VO
if D>99.9

vdc=VCC;
VDC=ones(size(t))*vdc;


        subplot(224);
    plot(t, VDC, 'LineWidth', 2);
    title('Output NE555');
    xlabel('Timp (secunde)');
    ylabel('Amplitudine (V)');
    ylim([0 VCC + 1]);
    grid on;


subplot(222)
hL=plot([0 1],[0 2*VCC/3], 'LineWidth', 2); 
title('Condensator');
 xlabel('Timp (secunde)');
    ylabel('Amplitudine (V)');
    grid on;
    

end
if D<99.9
%Afisare Incarcare si Descarcare Condensator

subplot(222)
plot(t, y_scaled, 'LineWidth', 2)
title('Condensator')
 xlabel('Timp (secunde)');
    ylabel('Amplitudine (V)');
grid on;

%afisare output
    subplot(224);
    plot(t, VCC * y_output, 'LineWidth', 2);
    title('Output');
    xlabel('Timp (secunde)');
    ylabel('Amplitudine (V)');
    ylim([0  VCC + 1]);
    grid on;
end

    %Creare semnal incarcare si descarcare condensator

    %afisare 1/3VCC
formattedlow = sprintf('%.2f', lower_limit);
uicontrol("Style","text",...
        "String","VCC/3",...
        "Units","normalized",...
        "Position",[0.05 0.25 0.35 0.1],...
        "Parent",ju,...
        "Fontsize",14)

    uicontrol("Style","edit",...
        "String",formattedlow,...
        "Units","normalized",...
        "Position",[0.55 0.25 0.15 0.1],...
        "Enable","off",...
        "Callback","buton_semnale",...
        "Parent",ju)

uicontrol("Style","text",...
        "String","[V]",...
        "Units","normalized",...
        "Position",[0.7 0.25 0.1 0.1],...
        "Parent",ju,...
        "FontSize",14)


    %afisare 2/3VCC
formattedhigh = sprintf('%.2f', upper_limit);
uicontrol("Style","text",...
        "String","2*VCC/3",...
        "Units","normalized",...
        "Position",[0.05 0 0.35 0.1],...
        "Parent",ju,...
        "Fontsize",14)

    uicontrol("Style","edit",...
        "String",formattedhigh ,...
        "Units","normalized",...
        "Position",[0.55 0 0.15 0.1],...
        "Enable","off",...
        "Callback","buton_semnale",...
        "Parent",ju)

uicontrol("Style","text",...
        "String","[V]",...
        "Units","normalized",...
        "Position",[0.7 0 0.1 0.1],...
        "Parent",ju,...
        "FontSize",14)

end
if z==2
    ju = uipanel("Units","normalized" ,...
      "Position",[0.35 0.6 0.15 0.3]);
%Generare Timp Trigger
T=1.1*R1*C;
f=1/T;
 t_total = numar_perioade * T;
 t = linspace(0, t_total, 1000);
%afisare perioada
uicontrol("Style","text",...
        "String","Perioada",...
        "Units","normalized",...
        "Position",[0.05 0.9 0.35 0.1],...
        "Parent",ju,...
        "Fontsize",14)

    uicontrol("Style","edit",...
        "String",T,...
        "Units","normalized",...
        "Position",[0.55 0.9 0.15 0.1],...
        "Enable","off",...
        "Callback","buton_semnale",...
        "Parent",ju)

 uicontrol("Style","text",...
        "String","s",...
        "Units","normalized",...
        "Position",[0.7 0.9 0.1 0.1],...
        "Parent",ju,...
        "FontSize",14)

 %afisare 2/3VCC

uicontrol("Style","text",...
        "String","2*VCC/3",...
        "Units","normalized",...
        "Position",[0.05 0.5 0.35 0.1],...
        "Parent",ju,...
        "Fontsize",14)

    uicontrol("Style","edit",...
        "String",upper_limit ,...
        "Units","normalized",...
        "Position",[0.55 0.5 0.15 0.1],...
        "Enable","off",...
        "Callback","buton_semnale",...
        "Parent",ju)

uicontrol("Style","text",...
        "String","[V]",...
        "Units","normalized",...
        "Position",[0.7 0.5 0.1 0.1],...
        "Parent",ju,...
        "FontSize",14)

uicontrol("Style","text",...
        "String","f",...
        "Units","normalized",...
        "Position",[0.05 0.1 0.35 0.1],...
        "Parent",ju,...
        "Fontsize",14)

    uicontrol("Style","edit",...
        "String",f,...
        "Units","normalized",...
        "Position",[0.55 0.1 0.15 0.1],...
        "Enable","off",...
        "Callback","buton_semnale",...
        "Parent",ju)

uicontrol("Style","text",...
        "String","Hz",...
        "Units","normalized",...
        "Position",[0.7 0.1 0.1 0.1],...
        "Parent",ju,...
        "FontSize",14)



  %Generare Output

 r=1;
y_output = (sign(sin(r * 2*pi*f * (t + T / 4))) + 1) / 2;




%Generare Linie dreapta ,cazul in care Trigger nu e apasat
if k==0
vdc=0;
VDC=ones(size(t))*vdc;


%Afisare output NE555 cu trigger neapasat
        subplot(224);
    plot(t, VDC, 'LineWidth', 2);
    title('Output NE555');
    xlabel('Timp (secunde)');
    ylabel('Amplitudine (V)');
    ylim([0 VCC + 1]);
    grid on;

end
if k==1
% Generează semnalul Trigger

amplitudine=1;
semnal = amplitudine * square(2 * pi * f * t, (timp_high / (timp_high + timp_low)) * 100);
semnal_translatat = (semnal + 1) / 2;



%Generare Incarcare descarcare Condensator in monostabil

A=1;
 x = A * asin(sin(2 * pi * f * t)) / pi;  
componenta_continua = 1*VCC/6;  
y = x + componenta_continua;  
lower_limit = 1 / 3 * VCC;
upper_limit = 2 / 3 * VCC;
y_scaled = (y - min(y)) / (max(y) - min(y)) * (upper_limit - lower_limit) + lower_limit;

% Creare axelor pentru grafice monostabil
axes3=axes("Position",[0.57 0.76 0.33 0.21]);
axes4=axes("Position",[0.57 0.5 0.33 0.21]);




%Afisare Trigger
grid on;
plot(axes3,t, semnal_translatat ,'LineWidth', 2);
title('Trigger');
ylim([0, 1.5]);


%Afisare output

plot(axes4,t, VCC * y_output, 'LineWidth', 2);
    title('Output');
    ylabel('Amplitudine (V)');
    ylim([0 VCC + 1]);
    grid on;




    %Afisare Incarcare descarcare Condensator in Monostabil
    subplot(224)
    plot(t, y_scaled, 'LineWidth', 2);
    title('Condensator');
    xlabel('Timp (secunde)');
    ylabel('Amplitudine (V)');
    ylim([0 VCC + 1]);
    grid on;
end
end