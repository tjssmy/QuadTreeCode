function PrintQTIntBCVals(IntBC)

QTGlobals

fprintf('Internal BCs:\n');

NetFlow = 0;

for i=1:length(IntBC)
    fprintf('\tRegion %i ',i);
    
    TotalFlow = 0;
    AveVal = 0;
    nb = length(IntBC(i).blocks);
    
    for j = 1:nb
        
        b = IntBC(i).blocks(j);
        
        AveVal = AveVal + Blocks{b}.data(VVAL);
        
        if IntBC(i).mode == 'v'
            for i = 1:MAX_NUM_BR
                if Blocks{b}.br(br)
                    TotalFlow = TotalFlow + Blocks{b}.data(VVAL)-...
                        Blocks{Blocks{b}.br(br)}.data(VVAL);
                end
            end
        elseif IntBC(i).mode == 'g'
            TotalFlow = TotalFlow + ...
                (Blocks{b}.data(VVAL)-IntBC(i).val(1))*IntBC(i).val(2);
        elseif IntBC(i).mode == 'm'
            TotalFlow = TotalFlow + ...
                (Blocks{b}.data(VVAL)-IntBC(i).val(1))*IntBC(i).val(2) + ...
                IntBC(i).val(3);
        end
    end
    NetFlow = NetFlow + TotalFlow;
    AveVal = AveVal/nb;
    fprintf(' Average Val = %f TotalFlow = %f\n',AveVal,TotalFlow);
    
end

fprintf('\n\tNetFlow = %f\n',NetFlow);

end