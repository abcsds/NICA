function Tcell = displayoutputmessage(T,Tcell,listbox)

    if isempty(Tcell)
        Tcell = regexp(T, '\n', 'split');
    else
        TcellNew = regexp(T, '\n', 'split');
        Tcell = [Tcell,TcellNew];
    end
    % Display Output
    set(listbox, 'String', Tcell);
    set(listbox,'Value', size(Tcell,2));
    
end