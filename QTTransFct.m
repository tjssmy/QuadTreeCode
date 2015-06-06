function [val ] = QTTransFct(mode,paras,t)

if mode == 'c'
    val = paras(1);
elseif mode == 'l'
        val = paras(1) + paras(2)*t;
elseif mode == 's'
    if t < paras(1)
        val = paras(2);
    else
        val = paras(3);
    end
end