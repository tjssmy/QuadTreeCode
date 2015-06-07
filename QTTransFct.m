function [val ] = QTTransFct(mode,paras,t)

if mode == 'c'
    val = paras(1);
elseif mode == 'l'
    if t < paras(3)
        val = paras(1) + paras(2)*t;
    else
         val = paras(1) + paras(2)*paras(3);
    end
elseif mode == 's'
    if t < paras(1)
        val = paras(2);
    else
        val = paras(3);
    end
end