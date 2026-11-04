 
 

local script_Parent = script.Parent;
local Parent = script_Parent.Parent.Parent;
local React = require(Parent.Shared.React);
local u1 = require(Parent);
local useEffect = React.useEffect;
local useSignal = require(script_Parent.useSignal);

return function() -- Line: 13, Name: useFavorites
    -- upvalues: React (copy), u1 (copy), useSignal (copy), useEffect (copy)
    local u2, u3 = React.useState(u1.GetCachedFavorites);
    useSignal(u1.FavoriteAdded, function(p4) -- Line: 16
        -- upvalues: u2 (copy), u3 (copy)
        local table_clone_ret = table.clone(u2);

        if not table.find(table_clone_ret, p4) then
            table.insert(table_clone_ret, 1, p4);
        end;

        u3(table_clone_ret);
    end, { u2 });
    useSignal(u1.FavoriteRemoved, function(p5) -- Line: 26
        -- upvalues: u2 (copy), u3 (copy)
        local table_clone_ret = table.clone(u2);
        local table_find_ret = table.find(table_clone_ret, p5);

        if table_find_ret then
            table.remove(table_clone_ret, table_find_ret);
        end;

        u3(table_clone_ret);
    end, { u2 });
    useEffect(function() -- Line: 37
        -- upvalues: u1 (ref), u3 (copy)
        u1.GetFavoritesAsync():andThen(u3);
    end, {});

    return u2;
end;