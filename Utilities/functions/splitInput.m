function [idx, val] = splitInput(x)
  % splits x.inNN = YY into [NN,YY]
  if ~isempty(x)
    fields = fieldnames(x);
    for I = 1:length(fields)
      inName = fields{I};
      idx(I) = str2double(inName(3:end));
      val(I) = x.(inName);
    end
  else
    idx = [];
    val = [];
  end
end
