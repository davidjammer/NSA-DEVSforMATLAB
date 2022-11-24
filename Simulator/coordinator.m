classdef coordinator < handle
    properties
	   parent  %parent coordinator
	   name
	   tl      %time of last event
	   tn      %time of next event
	   
	   D       %children
	   I       %couplings
	   
	   IC      %internal coupling
	   EIC     %external to internal coupling
	   IEC     %internal to external coupling
	   
	   R_IC
	   
	   eventlist
	   receivers
	   IMM     %imminent children
	   mail    %output mail bag
	   yparent %output message bag for parent
	   y       %output message bags
	   
	   debug_level
	   epsilon
	   
    end
    
    methods
	   %% constructor
	   function obj = coordinator(name)
		  obj.name = name;
		  obj.D = {};
		  obj.eventlist = [];
		  obj.y = [];
		  obj.mail = [];
		  obj.I = [];
		  obj.IC = [];
		  obj.EIC = [];
		  obj.IEC = [];
		  obj.R_IC = {};
		  obj.receivers=[];
		  obj.debug_level = get_debug_level();
		  obj.epsilon = get_epsilon();
	   end
	   %% copy methods
	   function mdl=copy(obj,name)
		  mdl = coordinator(obj.get_name);
		  
		  prop = properties(obj);
		  nprop = numel(prop);
		  
		  for k=1:nprop
			 if strcmp(prop{k},"parent")
				
			 elseif strcmp(prop{k},"D")
				for kk=1:numel(obj.D)
				    mdl.add_model(obj.D{kk}.copy(obj.D{kk}.get_name()));
				end
			 elseif strcmp(prop{k},"name")
				mdl.name = name;
			 else
				mdl.(prop{k}) = obj.(prop{k});
			 end
		  end
		  
		  for k=1:numel(mdl.I)
			 if strcmp(mdl.I(k).from_mdl,obj.name)
				mdl.I(k).from_mdl = mdl.name;
			 end
			 if strcmp(mdl.I(k).to_mdl,obj.name)
				mdl.I(k).to_mdl = mdl.name;
			 end
		  end
		  for k=1:numel(mdl.EIC)
			 if strcmp(mdl.EIC(k).from_mdl,obj.name)
				mdl.EIC(k).from_mdl = mdl.name;
			 end
		  end
		  for k=1:numel(mdl.IEC)
			 if strcmp(mdl.IEC(k).to_mdl,obj.name)
				mdl.IEC(k).to_mdl = mdl.name;
			 end
		  end
	   end
	   %% set methods
	   function set_parent(obj,value)
		  obj.parent = value;
	   end
	   %% add methods
	   function add_model(obj,mdl)
		  obj.D = {obj.D{:},mdl};
		  mdl.set_parent(obj);
	   end
	   function add_coupling(obj,from_mdl,from_port,to_mdl,to_port)
		  coupling.from_mdl = from_mdl;
		  coupling.from_port = from_port;
		  coupling.to_mdl = to_mdl;
		  coupling.to_port = to_port;
		  
		  obj.I = [obj.I, coupling];
		  
		  if(strcmp(coupling.from_mdl,obj.name))
			 %EIC
			 obj.EIC = [obj.EIC,coupling];
		  elseif(strcmp(coupling.to_mdl,obj.name))
			 %IEC
			 obj.IEC = [obj.IEC,coupling];
		  else
			 %IC
			 obj.IC = [obj.IC,coupling];
			 
			 
			 
		  end
		  
	   end
	   %% get methods
	   function n = get_deep(obj)
		 n = 0;
		 for i=1:length(obj.D)
			if isa(obj.D{i}, "coordinator")
			   n = max(n, obj.D{i}.get_deep()); 
			end
		 end
		 n = n + 1;
	   end
	   
	   function n = get_number_of_devs(obj)
		  n = 0;
		  for i=1:length(obj.D)
			 if isa(obj.D{i}, "devs")
				n = n + 1;
			 elseif isa(obj.D{i}, "coordinator")
				n = n + obj.D{i}.get_number_of_devs();
			 end
			 
		  end 
	   end
	   
	   function n = get_number_of_coordinator(obj)
		  n = 1;
		  for i=1:length(obj.D)
			 if isa(obj.D{i}, "coordinator")
				n = n + obj.D{i}.get_number_of_coordinator();
			 end
			 
		  end 
	   end
	   
	   function tn = get_tn(obj)
		  tn = obj.tn;
	   end
	   
	   function tl = get_tl(obj)
		  tl = obj.tl;
	   end
	   
	   function name = get_name(obj)
		  name = obj.name;
	   end
	   %%
	   function update_eventlist(obj, tn, tl, name)
		 idx = find_mdl_in_D(obj.D, name);
		 i = find(obj.eventlist(:,1) == idx);
		 obj.eventlist(i,2:3) = tn;
		 obj.eventlist(i,4:5) = tl;
	   end
	   
	   function sort_eventlist(obj)
		  obj.eventlist = sortrows(obj.eventlist,2);
		  
		  d=1;
		  [n,m]=size(obj.eventlist);
		  while(d<n)
			 x=find(obj.eventlist(:,2)==obj.eventlist(d,2));
			 
			 obj.eventlist(x(1):x(end),:)=sortrows(obj.eventlist(x(1):x(end),:),3);
			 
			 d=x(end)+1;
		  end
	   end
	   
	   function create_eventlist(obj)
		  %obj.eventlist=[];
		  %obj.eventlist = zeros(length(obj.D), 5);
		  for d=1:length(obj.D)
			 %obj.eventlist = [obj.eventlist;d,obj.D{d}.get_tn,obj.D{d}.get_tl];
			 %obj.eventlist(d,:) = [d,obj.D{d}.get_tn,obj.D{d}.get_tl];
			 obj.eventlist(d,1) = d;
			 obj.eventlist(d,2:3) = obj.D{d}.tn;
			 obj.eventlist(d,4:5) = obj.D{d}.tl;
		  end
	   end
	   
	   
	   
	   %% message functions
	   function imessage(obj,t)
		  if obj.debug_level == 1
			 sequenceaddlink(sprintf("(i,%4.2f+%4.2f\\epsilon)",t(1),t(2)),obj.get_name);
		  end
		  for d=1:length(obj.D)
			 obj.D{d}.imessage(t);
			 if obj.debug_level == 1
				otn = obj.D{d}.tn;
				sequenceaddlink(sprintf("(d,%4.2f+%4.2f\\epsilon)",otn(1),otn(2)),obj.get_name);
			 end
		  end
		  
		  obj.create_eventlist();
		  obj.sort_eventlist();
		  
		  obj.tl = [obj.eventlist(end,4), obj.eventlist(end,5)];
		  obj.tn = [obj.eventlist(1,2), obj.eventlist(1,3)];
	   end
	   
	   function smessage(obj,t)
		  if obj.debug_level == 1
			 disp(['coordinator: ' obj.name ' s-message']);
			 sequenceaddlink(sprintf('(*,%4.2f+%4.2f\\epsilon)',t(1),t(2)),obj.get_name);
		  end
		  if(t ~= obj.tn)
			 disp(['error in ' obj.name ' :']);
			 disp('in *-msg: simulation time (t) is not equal to time of next event (tn)');
			 disp(['simulation time: ' num2str(t)]);
			 disp(['time of next event: ' num2str(obj.tn)]);
			 pause();
		  end
		  
		  copy_of_eventlist = obj.eventlist;
		  
		  id = find_tn(copy_of_eventlist,obj.tn);
		  
		  obj.IMM = {};
		  
		  while ~isempty(id)
			 obj.IMM = {obj.IMM{:},obj.D{ copy_of_eventlist(id(1),1) } };
			 copy_of_eventlist(id(1),:) = [];
			 id = find_tn(copy_of_eventlist,obj.tn);
		  end
		  
		  for r=1:length(obj.IMM)
			 obj.IMM{r}.smessage(t);
		  end
		  
	   end
	   
	   function check_mail(obj)
		  %delete empty y-messages from mail
		  j=1;
		  while (j <= length(obj.mail))
			 if(isempty(obj.mail(j).y))
				obj.mail(j) = [];
			 else
				j = j+1;
			 end
		  end
	   end
	   
	   function check_external_couplings(obj)
		  %external couplings
		  obj.yparent = [];
		  for j=1:length(obj.mail)
			 name=obj.mail(j).name;
			 ports=fieldnames(obj.mail(j).y);
			 for l=1:length(ports)
				for k=1:length(obj.IEC)
				    if(strcmp(name,obj.IEC(k).from_mdl) && strcmp(ports(l),obj.IEC(k).from_port) )
					   obj.yparent.(obj.IEC(k).to_port) = obj.mail(j).y.(obj.IEC(k).from_port);
				    end
				end
			 end
		  end
		  
		  obj.receivers=[];
	   end
	   
	   function check_internal_couplings(obj)
		  %%internal couplings
		  for j=1:length(obj.mail)
			 name=obj.mail(j).name;
			 ports=fieldnames(obj.mail(j).y);
			 for l=1:length(ports)
				for k=1:length(obj.IC)
				    
				    if( strcmp(name,obj.IC(k).from_mdl) && strcmp(ports(l),obj.IC(k).from_port) )
					   
					   if(isempty(obj.receivers))
						  idx=[];
					   else
						  idx=find_mdl(obj.receivers,obj.IC(k).to_mdl);
					   end
					   
					   if(isempty(idx))
						  r=[];
						  r.name=obj.IC(k).to_mdl;
						  r.x.(obj.IC(k).to_port) = obj.mail(j).y.(obj.IC(k).from_port);
						  r.del = 0;
						  obj.receivers = [obj.receivers, r];
					   else
						  obj.receivers(idx).x.(obj.IC(k).to_port) = obj.mail(j).y.(obj.IC(k).from_port);
					   end
					   
				    end
				    
				end
			 end
		  end
	   end
	   
	   function ymessage(obj,y,name,t)
		  if obj.debug_level == 1
			 disp(['coordinator: ' obj.name ' y-message from: ' name ' value:']);
			 disp(y);
			 if isempty(y)
				sequenceaddlink(sprintf('(y,[])'),obj.get_name);
			 else
				sy = struct2string(y);
				sequenceaddlink(sprintf('(y,%s)',sy), obj.get_name);
			 end
		  end
		  
		  mail_d =[];
		  mail_d.name = name;
		  mail_d.y = y;
		  mail_d.t = t;
		  
		  obj.mail = [obj.mail, mail_d];
		  
		  if(length(obj.mail) == length(obj.IMM))
			 if obj.debug_level == 1
				disp(['coordinator: ' obj.name ' received all y-messages from children']);
			 end
			 
			 obj.check_mail();
			 obj.check_external_couplings();
			 obj.check_internal_couplings();
			 
			 if obj.debug_level == 1
				disp(['coordinator: ' obj.name ' send y-messages to parent; value: ']);
				disp(obj.yparent);
			 end
			 obj.parent.ymessage(obj.yparent,obj.name,t);
			 if obj.debug_level == 1
				sequenceaddlink('done',obj.get_name);
			 end
			 
			 
			 %Alle Komponenten die nicht von EIC abhängig sind werden hier bearbeitet!
			 %obj.R_IC={};
			 if isempty(obj.R_IC)
				for r=1:length(obj.D)
				    if~(any(arrayfun(@(x) strcmp(x.to_mdl,obj.D{r}.get_name()),obj.EIC)))
					   obj.R_IC={obj.R_IC{:},obj.D{r}};
				    end
				end
			 end
			 
			 
			 
			 
			 
			 %Komponenten die ein Event empfangen und in IC als
			 %Empfaenger vorhanden sind
			 for r=1:length(obj.receivers)
				idx = find_mdl_in_D(obj.R_IC, obj.receivers(r).name);
				if(~isempty(idx))
				    if obj.debug_level == 1
					   disp(['coordinator: ' obj.name ' send x-messages to child: ' obj.R_IC{idx}.get_name ' value: ']);
					   disp(obj.receivers(r).x);
				    end
				    obj.R_IC{idx}.xmessage(obj.receivers(r).x,t);
				    otn = obj.R_IC{idx}.tn;
				    
				    obj.update_eventlist(otn, t, obj.receivers(r).name);
				    
				    idx = find_mdl_in_D(obj.IMM, obj.receivers(r).name);
				    if(~isempty(idx))
					   obj.IMM{idx}={};
				    end
				    
				    %
				    obj.receivers(r).del = 1;
				    %
				    if obj.debug_level == 1
					   sequenceaddlink(sprintf("(d,%4.2f+%4.2f\\epsilon)",otn(1),otn(2)),obj.get_name);
				    end
				else
				    
				    
				    %                       disp(['error in ' obj.name ' :']);
				    %                       disp(['in y-msg: can not find the model ' obj.receivers(r).name ' in R_IC']);
				    
				    
				    %                       pause();
				end
			 end
			 
			 rec = [];
			 for r=1:length(obj.receivers)
				if obj.receivers(r).del == 0
				    rec = [rec obj.receivers(r)];
				end
			 end
			 obj.receivers = rec;
			 
			 
			 %Komponenten die in IMM sind und kein Event bekommen haben
			 %und in IC als Empaenger vorhanden sind
			 for d=1:length(obj.R_IC)
				idx = find_mdl_in_D(obj.IMM, obj.R_IC{d}.get_name);
				if(~isempty(idx))
				    if obj.debug_level == 1
					   disp(['coordinator: ' obj.name ' send empty x-messages to child: ' obj.IMM{idx}.get_name]);
				    end
				    obj.IMM{idx}.xmessage([],t);
				    otn = obj.IMM{idx}.tn;
				    obj.update_eventlist(otn, t, obj.IMM{idx}.get_name);
				    if obj.debug_level == 1
					   sequenceaddlink(sprintf("(d,%4.2f+%4.2f\\epsilon)",otn(1),otn(2)),obj.get_name);
				    end
				    obj.IMM{idx}={};
				end
			 end
			 
			 obj.mail = [];
			 
			 obj.sort_eventlist();
			 obj.tl = t;
			 obj.tn = [obj.eventlist(1,2),obj.eventlist(1,3)];
			 
		  else
			 if obj.debug_level == 1
				disp(['coordinator: ' obj.name ' received ' num2str(length(obj.mail)) '/' num2str(length(obj.IMM)) ' y-messages ']);
			 end
		  end
		  
	   end
	   
	   function xmessage(obj,x,t)
		  if obj.debug_level == 1
			 disp(['coordinator: ' obj.name ' x-message' ' value:']);
			 disp(x);
			 if isempty(x)
				sequenceaddlink(sprintf('(x,[],%4.2f+%4.2f\\epsilon)',t(1),t(2)),obj.get_name);
			 else
				sx = struct2string(x);
				sequenceaddlink(sprintf('(x,%s,%4.2f+%4.2f\\epsilon)',sx,t(1),t(2)),obj.get_name);
			 end
		  end
		  
		  if ~isempty(x)
			 %EIC
			 ports = fieldnames(x);
			 for k=1:length(ports)
				for d=1:length(obj.EIC)
				    
				    if(strcmp(ports(k),obj.EIC(d).from_port))
					   if(isempty(obj.receivers))
						  idx=[];
					   else
						  idx=find_mdl(obj.receivers,obj.EIC(d).to_mdl);
					   end
					   
					   if(isempty(idx))
						  r=[];
						  r.name =  obj.EIC(d).to_mdl;
						  r.x.(obj.EIC(d).to_port) = x.(obj.EIC(d).from_port);
						  r.del = 0;
						  obj.receivers = [obj.receivers,r];
					   else
						  %r(idx).name =  obj.EIC(d).to_mdl;
						  obj.receivers(idx).x.(obj.EIC(d).to_port) = x.(obj.EIC(d).from_port);
					   end
					   
				    end
				end
			 end
		  end
		  
		  %send x-message for receivers
		  for r=1:length(obj.receivers)
			 idx = find_mdl_in_D(obj.D, obj.receivers(r).name);
			 if(~isempty(idx))
				if obj.debug_level == 1
				    disp(['coordinator: ' obj.name ' send x-messages to child: ' obj.D{idx}.get_name ' value: ']);
				    disp(obj.receivers(r).x);
				end
				obj.D{idx}.xmessage(obj.receivers(r).x,t);
				
				otn = obj.D{idx}.tn;
				obj.update_eventlist(otn, t, obj.D{idx}.get_name());
				if obj.debug_level == 1
				    sequenceaddlink('done',obj.get_name);
				end
			 else
				
				disp(['error in ' obj.name ' :']);
				disp(['in x-msg: can not find the model ' obj.receivers(r).name ' in D']);
				
				pause();
			 end
		  end
		  
		  for r=1:length(obj.receivers)
			 idx = find_mdl_in_D(obj.IMM, obj.receivers(r).name);
			 if(~isempty(idx))
				obj.IMM{idx}={};
			 end
		  end
		  
		  
		  for d=1:length(obj.IMM)
			 if(~isempty(obj.IMM{d}))
				if obj.debug_level == 1
				    disp(['coordinator: ' obj.name ' send empty x-messages to child: ' obj.IMM{d}.get_name]);
				end
				obj.IMM{d}.xmessage([],t);
				otn = obj.IMM{d}.tn;
				obj.update_eventlist(otn, t, obj.IMM{d}.get_name());
				if obj.debug_level == 1
				    sequenceaddlink('done',obj.get_name);
				end
			 end
		  end
		  
		  obj.mail = [];
		  obj.IMM={};
		  obj.receivers=[];
		  obj.sort_eventlist();
		  obj.tl = t;
		  obj.tn = [obj.eventlist(1,2),obj.eventlist(1,3)];
	   end
    end
    
end






