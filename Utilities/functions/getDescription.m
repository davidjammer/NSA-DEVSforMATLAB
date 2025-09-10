function sDesc = getDescription(s)
  % returns string description of a variable s
  sDesc = "";
  if isempty(s)
    sDesc = sDesc + "[]";
  elseif iscell(s)
    sDesc = sDesc + "{";
    for I=1:length(s) - 1
      val = s{I};
      sDesc = sDesc + getValDescription(val) + " ";
    end
    sDesc = sDesc + getValDescription(s{end});
    sDesc = sDesc + "}";
  elseif isvector(s) && length(s) > 1
    sDesc = sDesc + "[";
    for I=1:length(s)-1
      sDesc = sDesc + getDescription(s(I)) + ",";
    end
    sDesc = sDesc + getDescription(s(end)) + "]";
  elseif isstruct(s)
    % display fieldnames and values
    fields = fieldnames(s);
    sDesc = sDesc + "(";
    for I=1:length(fields)-1
      val = s.(fields{I});
      sDesc = sDesc + fields{I} + ":" + getDescription(val) + " ";
    end
    val = s.(fields{end});
    sDesc = sDesc + fields{end} + ":" + getDescription(val);
    sDesc = sDesc + ")";
  else
    sDesc = getValDescription(s);
  end
end

function sDesc = getValDescription(val)
  % returns string description of a simple value s
  if isnumeric(val)
    sDesc = sprintf("%5.3f", val);
  elseif isstring(val)
    sDesc = sprintf("%s", val);
  elseif islogical(val)
    sDesc = sprintf("%s", mat2str(val));
  else
    sDesc = sprintf("%s", class(val));
  end
end