classdef devs < handle
  properties
    parent  %parent coordinator
    tl      %time of last event
    tn      %time of next event
    DEVS    %model
    y       %output message bag
    e
    x
    debug_level
    epsilon
    mu
    r      %default input delay
  end

  methods
    %% constructor
    function obj = devs(mdl)
      obj.DEVS = mdl;
      obj.e = [0,0];
      obj.x = [];
      obj.epsilon = get_epsilon();
      obj.debug_level = get_debug_level();
      obj.mu = get_mu();
      obj.r = get_defdelay();
    end
    %% set methods
    function set_parent(obj,value)
      obj.parent = value;
    end

    function set_model(obj,value)
      obj.DEVS = value;
    end
    %% get methods
    function tn = get_tn(obj)
      tn = obj.tn;
    end

    function tl = get_tl(obj)
      tl = obj.tl;
    end

    function name = get_name(obj)
      name = obj.DEVS.name;
    end

    function state = get_state(obj)
      state = obj.DEVS.s;
    end
    %% copy methods
    function DEVS=copy(obj,name)
      args=cell(nargin(class(obj.DEVS)),1);
      mdl = feval(class(obj.DEVS),args{:});

      prop = properties(obj.DEVS);
      nprop = numel(prop);

      for k=1:nprop
        if strcmp(prop{k},'name')
          mdl.(prop{k}) = name;
        else
          mdl.(prop{k}) = obj.DEVS.(prop{k});
        end
      end

      DEVS = devs(mdl);

    end
    %% message functions
    function imessage(obj,t)
      obj.tl = t - obj.e;
      obj.tn = obj.tl + obj.DEVS.ta();
      if obj.debug_level == 1
        sequenceaddlink(sprintf('(i,%4.2f+%4.2f\\epsilon)',t(1),t(2)),obj.get_name);
        sequenceaddlink(sprintf('ta(s)'),obj.get_name);
      end
    end
    function smessage(obj,t)
      if obj.debug_level == 1
        disp(['simulator: ' obj.DEVS.name ' s-message']);
        sequenceaddlink(sprintf('(*,%4.2f+%4.2f\\epsilon)',t(1),t(2)),obj.get_name);
      end

      if obj.debug_level == 1
        disp('call lambda');
        sequenceaddlink('\lambda (s,e,x)',obj.get_name);
      end
      obj.e = [t(1) - obj.tl(1), t(2) - obj.tl(2)];
      obj.y = obj.DEVS.lambda(obj.e,obj.x);
      obj.parent.ymessage(obj.y,obj.get_name,t);


    end
    function xmessage(obj,x,t)
      if obj.debug_level == 1
        disp(['simulator: ' obj.DEVS.name ' x-message ' 'value:']);
        disp(x);
        disp('old state: ');
        disp(obj.DEVS.s);
        if isempty(x)
          sequenceaddlink(sprintf('(x,[],%4.2f+%4.2f\\epsilon)',t(1),t(2)),obj.get_name);
        else
          sx = struct2string(x);
          sequenceaddlink(sprintf('(x,%s,%4.2f+%4.2f\\epsilon)',sx,t(1),t(2)),obj.get_name);
        end
      end

      if isempty(x)
        if obj.debug_level == 1
          sequenceaddlink('\delta (s,e,x)',obj.get_name);
        end


        obj.e = [t(1) - obj.tl(1), t(2) - obj.tl(2)];
        obj.DEVS.delta(obj.e,obj.x);
        obj.x = [];

        tb = obj.DEVS.ta();
        if isscalar(tb)
          tb=[tb,0];
        end

        if (tb(1)==0 && tb(2)==0)
          tb = [0,obj.r];
        end
        if (tb(1) == 0)
          if obj.mu == 0
            obj.tn = [t(1), t(2) + tb(2)];
          else
            obj.tn = [t(1) + tb(2) * obj.mu, 0];
          end
        else
          obj.tn = [t(1) + tb(1), 0];
        end
        obj.tl = t;
      else
        if ~isempty(obj.x)
          names = fieldnames(x);

          for i=1:length(names)
            obj.x.(names{i}) = x.(names{i});
          end

        else
          obj.x = x;
        end

        if obj.mu == 0
          obj.tn = [t(1) + obj.DEVS.tau(1), t(2) + obj.DEVS.tau(2)];
        else
          obj.tn = [t(1) + obj.DEVS.tau(1) + obj.mu * obj.DEVS.tau(2), 0];
        end
      end



      if obj.debug_level == 1
        disp(['tnext: ' num2str(obj.tn)]);
        sequenceaddlink('ta(s)',obj.get_name);
      end
    end

  end
end
