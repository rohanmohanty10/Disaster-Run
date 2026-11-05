  

 

local new = Instance.new;

return function(u1, p2) -- Line: 14
    -- upvalues: new (copy)
    return function(u3) -- Line: 15
        -- upvalues: new (ref), u1 (copy)
        local v4 = {};

        if typeof(u3) == "string" then
            local success, result = pcall(function() -- Line: 21
                -- upvalues: new (ref), u3 (copy)
                return new(u3);
            end);

            if success then
                return function(p5) -- Line: 27
                    -- upvalues: result (copy)
                    for i, v in pairs(p5) do
                        if i == "Parent" then
                            result.Parent = v;
                        elseif i == "Children" then
                            for i2, v2 in pairs(v) do
                                v2.Parent = result;
                                v2.Name = i2;
                            end;
                        elseif i == "Function" then
                            v(result);
                        elseif i == "Attributes" then
                            for i2, v2 in pairs(v) do
                                result:SetAttribute(i2, v2);
                            end;
                        end;

                        pcall(function() -- Line: 44
                            -- upvalues: result (ref), i (copy), v (copy)
                            if typeof(result[i]) ~= "RBXScriptSignal" then
                                result[i] = v;

                                return;
                            end;

                            if typeof(v) == "function" then
                                result[i]:Connect(v);

                                return;
                            end;

                            warn("function expected for signal binding event:", i, ", got", (typeof(v)));
                        end);
                    end;

                    return result;
                end;
            end;

            local v6 = u1.LazyLoader:pullDirectory("Classes");

            if not success and v6[u3] == nil then
                warn("Couldn\'t create class/instance: ", u3, debug.traceback("\n"));

                return nil;
            end;

            local v7 = u1.Require(v6[u3])(u1);

            if v7.new == nil then
                table.insert(v4, v6[u3]);

                return v7;
            end;

            table.insert(v4, v7.new());
        else
            if typeof(u3) ~= "table" then
                warn(debug.traceback(), ("Invalid type (%s) given to constructor"):format((typeof(u3))));

                return nil;
            end;

            local v8 = u1.LazyLoader:pullDirectory("Classes");

            if #u3 < 1 then
                return nil;
            end;

            for i = 1, #u3 do
                local success, result = pcall(function() -- Line: 79
                    -- upvalues: u3 (copy), i (copy)
                    return Instance.new(u3[i]);
                end);

                if success then
                    table.insert(v4, result);
                elseif success or v8[u3[i]] ~= nil then
                    local v9 = u1.Require(v8[u3[i]])(u1);

                    if v9.new == nil then
                        table.insert(v4, v8[u3]);

                        return nil;
                    end;

                    table.insert(v4, v9.new());
                else
                    warn("Couldn\'t create class/instance: ", u3[i]);
                end;
            end;
        end;

        return unpack(v4);
    end;
end;