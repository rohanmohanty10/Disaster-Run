  

 

return {
    subscribe = function(u1, u2, u3) -- Line: 3, Name: subscribe
        if u1 and typeof(u1) == "userdata" then
            local _obj = u1._obj;
            local _subscriptions = u1._subscriptions;

            if not _subscriptions then
                u1._subscriptions = {};
                _subscriptions = u1._subscriptions;
            end;

            _subscriptions[u2] = _obj:GetPropertyChangedSignal(u2):Connect(function() -- Line: 13
                -- upvalues: u1 (copy), u2 (copy), u3 (copy)
                u3(u1[u2]);
            end);
        end;
    end,

    unsubscribe = function(p4, p5) -- Line: 21, Name: unsubscribe
        if p4 and typeof(p4) == "userdata" then
            local _ = p4._obj;
            local _subscriptions = p4._subscriptions;

            if _subscriptions and _subscriptions[p5] then
                _subscriptions[p5]:Disconnect();
                _subscriptions[p5] = nil;
            end;
        end;
    end
};