function sDesc = getDescription(s)
  % returns string description of a variable s
  if isstruct(s)
    % display fieldnames and values
    fields = fieldnames(s);
    sDesc = "";
    for I=1:length(fields)
      val = s.(fields{I});
      sDesc = sDesc + fields{I} + ":" + getValDescription(val);
    end
  else
    sDesc = getValDescription(s);
  end
end


function sDesc = getValDescription(val)
  % returns string description of a simple value s
  if isnumeric(val)
    sDesc = sprintf("%5.3f ", val);
  elseif isstring(val)
    sDesc = sprintf("%s ", val);
  else
    sDesc = sprintf("%s ", class(val));
  end
end