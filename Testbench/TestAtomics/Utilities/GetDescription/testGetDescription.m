function out = testGetDescription(nr)
if nargin == 0
  nr = 1;
end

switch nr
  case 1
    s = 1.0;   % -> "1.000"
  case 2
    s = pi;   % -> "3.142"
  case 3
    s = "juhu";   % -> "juhu"
  case 4
    s = true;   % -> "true"
  case 5
    s = timeseries((3:3:15)',(1:5)', "Name","Juhu");   % -> "timeseries"
  case 6
    s = zeros(3,0);   % -> "[]"
  case 7
    s = 2.1:1.1:4.5;   % -> "[2.100,3.200,4.300]"
  case 8
    s = struct("id", 3, "name", "klaus");   % -> "(id:3.000 name:klaus)"
  case 9
    s = {"bla", 2};   % -> "{bla 2.000}"
  case 10
    s = struct("name", {"Bart", "Lisa", "Maggie"}, "alter", {10, 8, 1});
    % -> "[(name:Bart alter:10.000),(name:Lisa alter:8.000),(name:Maggie alter:1.000)]"
  case 11
    q = struct("id", {4}, "val", {2});
    qR = struct("id", {7,8}, "val", {1,2});
    s = struct("phase", "Blocked", "q", q, "qR", qR);
    % -> "(phase:Blocked q:(id:4.000 val:2.000) "
    %       + "qR:[(id:7.000 val:1.000),(id:8.000 val:2.000)])"
  otherwise
    s = 1.0;
end

sDesc = getDescription(s);
out.sDesc = sDesc;
