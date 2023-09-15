function [from_model,from_port,to_model,to_port] = get_coupling(name, line)
    srcBlock=get_param(line,'SrcBlockHandle');
    srcPort=get_param(line,'SrcPortHandle');
    dstBlock=get_param(line,'DstBlockHandle');
    dstPort=get_param(line,'DstPortHandle');

    for i=1:length(dstBlock)
        if get_param(srcBlock,'BlockType') == "Inport"
            from_model{i} = name;
        else
            from_model{i} = get_param(srcBlock,'Name');
        end

        if get_param(dstBlock(i),'BlockType') == "Outport"
            to_model{i} = name;
        else
            to_model{i} = get_param(dstBlock(i),'Name');
        end
    
        if get_param(srcBlock,'BlockType') == "Inport"
            from_port{i} = get_param(srcBlock, 'Name');
        else
            srcPortNumber = get_param(srcPort,'PortNumber');
            outport = find_system(srcBlock, 'LookUnderMasks', 'on', 'FollowLinks', 'on', 'SearchDepth', 1, 'BlockType', 'Outport');
            from_port{i} = get_param(outport(srcPortNumber),'Name');
        end

        if get_param(dstBlock(i),'BlockType') == "Outport"
            to_port{i} =  get_param(dstBlock(i),'Name');
        else
            dstPortNumber = get_param(dstPort(i),'PortNumber');
            inport = find_system(dstBlock(i), 'LookUnderMasks', 'on', 'FollowLinks', 'on', 'SearchDepth', 1, 'BlockType', 'Inport');
            to_port{i} = get_param(inport(dstPortNumber),'Name');
        end
    
        
    end
end

