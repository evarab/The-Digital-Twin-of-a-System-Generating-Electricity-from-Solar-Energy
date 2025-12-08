function PVPanelGUI
    params = [1.9098, 1e-9, 1e-11, 500, 0.1, 36, 36];

    fig = figure('Name','PV Panel IV-PV GUI','Position',[100 100 700 500]);

    uicontrol('Style','text','Position',[30 445 100 25],'String','Işınım (G, W/m²):','FontSize',10,'HorizontalAlignment','left');
    hG = uicontrol('Style','edit','Position',[140 450 80 25],'String','636.6','FontSize',10);

    uicontrol('Style','text','Position',[250 445 100 25],'String','Sıcaklık (T, °C):','FontSize',10,'HorizontalAlignment','left');
    hT = uicontrol('Style','edit','Position',[360 450 80 25],'String','25','FontSize',10);

    hButton = uicontrol('Style','pushbutton','Position',[470 450 100 30],'String','Hesapla','FontSize',12,'Callback',@hesapla);

    hAxes1 = axes('Parent',fig,'Position',[0.08,0.35,0.4,0.45]);
    title('IV Eğrisi'); xlabel('V (V)'); ylabel('I (A)'); grid on;

    hAxes2 = axes('Parent',fig,'Position',[0.57,0.35,0.4,0.45]);
    title('PV Eğrisi'); xlabel('V (V)'); ylabel('P (W)'); grid on;

    uipanel('Title','Sonuçlar','FontSize',12,'Position',[30 30 640 80]);
    hIsc = uicontrol('Style','text','Position',[50 70 100 25],'HorizontalAlignment','left','String','Isc:');
    hVoc = uicontrol('Style','text','Position',[170 70 100 25],'HorizontalAlignment','left','String','Voc:');
    hPmax = uicontrol('Style','text','Position',[290 70 120 25],'HorizontalAlignment','left','String','Pmax:');
    hVmp = uicontrol('Style','text','Position',[430 70 100 25],'HorizontalAlignment','left','String','Vmp:');
    hImp = uicontrol('Style','text','Position',[550 70 100 25],'HorizontalAlignment','left','String','Imp:');

    function hesapla(~,~)
        G = str2double(hG.String);
        T = str2double(hT.String);

        Voc_nominal = 25; 
        V = linspace(0,Voc_nominal,200);

        I0 = params(1) * (G / 636.6); % Referans ışınıma göre ölçekle

        try
            I = Ipv_newton_dd(params, V, I0*ones(size(V)), G, T);
        catch err
            errordlg(['Hesaplama hatası: ' err.message]);
            return;
        end
        P = V .* I;

        axes(hAxes1);
        cla; plot(V,I,'b','LineWidth',2); grid on;
        xlabel('V (V)'); ylabel('I (A)'); title('IV Eğrisi');

        axes(hAxes2);
        cla; plot(V,P,'r','LineWidth',2); grid on;
        xlabel('V (V)'); ylabel('P (W)'); title('PV Eğrisi');

        Isc = I(1);
        [Pmax, idx] = max(P);
        Vmp = V(idx);
        Imp = I(idx);
        Voc_idx = find(I<0.01,1);
        if isempty(Voc_idx)
            Voc = V(end);
        else
            Voc = V(Voc_idx);
        end

        hIsc.String = sprintf('Isc: %.3f A', Isc);
        hVoc.String = sprintf('Voc: %.3f V', Voc);
        hPmax.String = sprintf('Pmax: %.2f W', Pmax);
        hVmp.String = sprintf('Vmp: %.3f V', Vmp);
        hImp.String = sprintf('Imp: %.3f A', Imp);
    end
end