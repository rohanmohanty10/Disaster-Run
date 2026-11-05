 
return function() --[[ Line: 2 ]]
    local l_BindableEvent_0 = Instance.new("BindableEvent");
    local v5 = {
        Connect = function(_, v2) --[[ Line: 5 ]] --[[ Name: Connect ]]
            l_BindableEvent_0.Event:Connect(v2);
        end, 
        Fire = function(_, ...) --[[ Line: 8 ]] --[[ Name: Fire ]]
            l_BindableEvent_0:Fire(...);
        end, 
        Wait = function(_, ...) --[[ Line: 11 ]] --[[ Name: Wait ]]
            return l_BindableEvent_0.Event:Wait();
        end, 
        Object = l_BindableEvent_0
    };
    local l_Connect_0 = v5.Connect;
    local l_Fire_0 = v5.Fire;
    local l_Wait_0 = v5.Wait;
    v5.connect = l_Connect_0;
    v5.fire = l_Fire_0;
    v5.wait = l_Wait_0;
    return v5;
end;