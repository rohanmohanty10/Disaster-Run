  

 

local v1 = { "MouseButton1", "MouseButton2", "MouseButton3", "F", "C", "X", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Zero", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "A", "S", "D", "G", "H", "J", "K", "L", "Z", "V", "B", "N", "M", "P" };

for i, v in v1 do
    v1[i] = v:upper();
end;

return v1;