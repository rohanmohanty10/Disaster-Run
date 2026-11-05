  

 

return function(p1) -- Line: 2, Name: disconnectAndClear
    for _, v in p1 do
        v:Disconnect();
    end;

    table.clear(p1);
end;