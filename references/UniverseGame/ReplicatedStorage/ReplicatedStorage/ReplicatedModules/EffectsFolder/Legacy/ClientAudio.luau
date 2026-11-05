  

 

return function(p1) -- Line: 1
    local v2 = p1:Clone();
    v2.Parent = workspace.Effects;
    v2:Play();
    v2.Ended:Wait();
    v2:Destroy();
end;