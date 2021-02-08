function [s_signal1, s_signal2, wl760, wl830]=Konzentrationsberechnung_NIRx(NIRx)

    %Konzentrationsberechnung

        %Für vergleich mit Hitachi etg 4000 [hier werden die
        % extinktionskoeffizienten in [1/(mM*mm)].
        % des weiteren wird die effektive länge des optischen pfades nicht 
        % berechnet sonder in die Konzentration miteingerechnet. delta Coxy(Hitachi)
        % =delta Coxy*d somit ist für diese berechnung x1 und x2 =1 sowie auch d=1


        %ext_coeff=[0.1675 0.06096;0.07804 0.1051]; %[760nm;830nm] cope (old)
        ext_coeff=[0.1675 0.06096;0.07861 0.11596]; %[760nm;850nm] cope (new)
        x1=1; %DPF für 760nm (x_670)%6.2621                                               !!!! CHECK !!!!!!!!!!!
        x2=1; %DPF für 830nm (x_890)%4.9048
        d=1;
        inv_ext_coeff=inv(ext_coeff);


    for i=1:1:size(NIRx.Data.wl760,2)

        rohdaten(:,1)=NIRx.Data.wl760(:,i); %???
        rohdaten(:,2)=NIRx.Data.wl830(:,i);
%         rohdaten(:,2)=NIRx.Data.wl760(:,i); %???
%         rohdaten(:,1)=NIRx.Data.wl830(:,i);

        Daten=[rohdaten(:,1)' ;rohdaten(:,2)'];     %Aufbau von Daten
        A=zeros(size(Daten,1),size(Daten,2)-1);     %Festelegen der Matrixgröß.
        A(1,:)=(log10(Daten(1,1:end-1)./Daten(1,2:end)))/(x1*d); %Delta_A_760
        A(2,:)=(log10(Daten(2,1:end-1)./Daten(2,2:end)))/(x2*d); %Delta_A_830

        C=zeros(size(A))'; %Notwendig da sonst die alten Daten erhalten bleiben

        for g=1:length(A)        
            C(g,1)=inv_ext_coeff(1,:)*A(:,g);
            C(g,2)=inv_ext_coeff(2,:)*A(:,g);
        end

        Konz=cumsum(C,1);
        wl760(:,i) = C(:,1);
        wl830(:,i) = C(:,2);

        s_signal1(:,i)=[Konz(1,1); Konz(:,1)]; 
        s_signal2(:,i)=[Konz(1,2); Konz(:,2)];

        clear rohdaten Daten A C Konz

    end








end
