classdef rootcoordinator
    
    properties
        mi
        name
        tstart
        tend
        mdl
        stepwise
        display
        debug_level
    end
    
    methods
        function obj = rootcoordinator(name,tstart,tend,mdl,stepwise,display)
           obj.name = name;
           obj.tstart = [tstart,0];
           obj.tend = [tend,0];
           obj.mi = get_mi();
           obj.debug_level = get_debug_level();
           obj.mdl = mdl;
           obj.stepwise = stepwise;
           if exist('display','var')
                obj.display = display;
           else
               obj.display = 1;
           end
           mdl.set_parent(obj);
           
        end
        function sim(obj)
            
            t=obj.tstart;
            if obj.debug_level == 1
                sequencestart('NSA-DEVS');
                sequenceaddlink('start','root');
            end
            obj.mdl.imessage(t);
            if obj.debug_level == 1
                otn = obj.mdl.tn;
                s = sprintf("(d,%4.2f+%4.2f\\epsilon)",otn(1),otn(2));
                sequenceaddlink(s,'root');
            end
            t=obj.mdl.get_tn();
            %simt = t(1) + t(2) * obj.mi;
		    simt = t(1);
            if obj.display == 1
                disp(['t: ' num2str(simt)]);
                disp(['t: ' num2str(t(1)) ' + ' num2str(t(2)) 'E']);
            end
            while (t(1) <= obj.tend(1))
                obj.mdl.smessage(t);
                if obj.debug_level == 1
                  otn = obj.mdl.tn;
                  %sequenceaddlink('XXdone','root');
                  sequenceaddlink(sprintf("(d,%4.2f+%4.2f\\epsilon)",otn(1),otn(2)),'root');
                end
                if obj.display == 1
                    disp('-------------------------------------------------------------------------------');
                end
                t=obj.mdl.get_tn();
                if obj.display == 1
                    simt = t(1);
                    disp(['t: ' num2str(simt)]);
                    disp(['t: ' num2str(t(1)) ' + ' num2str(t(2)) 'E']);
                end
                if(obj.stepwise)
                    pause();
                end
            end
            if obj.debug_level == 1
                SD = getappdata(gcf,'SD');
                nodes={};
                for k=1:length(SD.nodes)
                    nodes={nodes{:},SD.nodes(k).name};
                end
                
                xticks(1:length(SD.nodes));
                xticklabels(nodes);
                xtickangle(90);
            end
        end
        function ymessage(obj,y,name,t)
            if obj.debug_level == 1
                if isempty(y)
                    s=sprintf('(y,[])');
                    sequenceaddlink(s,obj.name);
                else
                    sequenceaddlink(sprintf('(y,Y)'),obj.name);
                end
            end
        end
    end
    
end

