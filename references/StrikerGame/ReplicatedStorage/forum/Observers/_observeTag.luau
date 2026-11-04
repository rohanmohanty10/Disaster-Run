 

 

local CollectionService = game:GetService("CollectionService");

function observeTag(u1: string, u2: function, u3: table?)
    -- upvalues: CollectionService (copy)
    local u4 = {};
    local u5 = {};
    local u6 = nil;

    local function IsGoodAncestor(p7: userdata) -- Line: 63
        -- upvalues: u3 (copy)
        if u3 == nil then
            return true;
        end;

        for _, v in u3 do
            if p7:IsDescendantOf(v) then
                return true;
            end;
        end;

        return false;
    end;

    local function AttemptStartup(u8: userdata) -- Line: 77
        -- upvalues: u4 (copy), u3 (copy), u2 (copy), u1 (copy)
        u4[u8] = "__inflight__";
        task.spawn(function() -- Line: 82
            -- upvalues: u4 (ref), u8 (copy), u3 (ref), u2 (ref), u1 (ref)
            if u4[u8] ~= "__inflight__" then
                return;
            end;

            local v9 = u8;
            local v10;

            if u3 == nil then
                v10 = true;
            else
                v10 = false;

                for _, v in u3 do
                    if v9:IsDescendantOf(v) then
                        v10 = true;
                        break;
                    end;
                end;
            end;

            if not v10 then
                u4[u8] = "__dead__";

                return;
            end;

            local v14, v15 = xpcall(function(p11: userdata) -- Line: 94
                -- upvalues: u2 (ref)
                local v12 = u2(p11);

                if v12 ~= nil then
                    local v13 = typeof(v12) == "function";
                    assert(v13, "callback must return a function or nil");
                end;

                return v12;
            end, debug.traceback, u8);

            if v14 then
                if u4[u8] == "__inflight__" then
                    u4[u8] = v15;
                elseif v15 ~= nil then
                    task.spawn(v15);

                    return;
                end;

                return;
            end;

            local v16 = string.split(v15, "\n")[1];
            local string_find_ret = string.find(v16, ": ");
            local v17 = not string_find_ret and "" or v16:sub(string_find_ret + 1);
            warn((`error while calling observeTag("{u1}") callback:{v17}\n{v15}`));
        end);
    end;

    local function AttemptCleanup(p18: userdata) -- Line: 126
        -- upvalues: u4 (copy)
        local v19 = u4[p18];
        u4[p18] = "__dead__";

        if typeof(v19) == "function" then
            task.spawn(v19);
        end;
    end;

    local function OnAncestryChanged(u20: userdata) -- Line: 135
        -- upvalues: u3 (copy), u4 (copy), u2 (copy), u1 (copy)
        local v21;

        if u3 == nil then
            v21 = true;
        else
            v21 = false;

            for _, v in u3 do
                if u20:IsDescendantOf(v) then
                    v21 = true;
                    break;
                end;
            end;
        end;

        if v21 then
            if u4[u20] == "__dead__" then
                u4[u20] = "__inflight__";
                task.spawn(function() -- Line: 82
                    -- upvalues: u4 (ref), u20 (copy), u3 (ref), u2 (ref), u1 (ref)
                    if u4[u20] ~= "__inflight__" then
                        return;
                    end;

                    local v22 = u20;
                    local v23;

                    if u3 == nil then
                        v23 = true;
                    else
                        v23 = false;

                        for _, v in u3 do
                            if v22:IsDescendantOf(v) then
                                v23 = true;
                                break;
                            end;
                        end;
                    end;

                    if not v23 then
                        u4[u20] = "__dead__";

                        return;
                    end;

                    local v27, v28 = xpcall(function(p24: userdata) -- Line: 94
                        -- upvalues: u2 (ref)
                        local v25 = u2(p24);

                        if v25 ~= nil then
                            local v26 = typeof(v25) == "function";
                            assert(v26, "callback must return a function or nil");
                        end;

                        return v25;
                    end, debug.traceback, u20);

                    if v27 then
                        if u4[u20] == "__inflight__" then
                            u4[u20] = v28;
                        elseif v28 ~= nil then
                            task.spawn(v28);

                            return;
                        end;

                        return;
                    end;

                    local v29 = string.split(v28, "\n")[1];
                    local string_find_ret = string.find(v29, ": ");
                    local v30 = not string_find_ret and "" or v29:sub(string_find_ret + 1);
                    warn((`error while calling observeTag("{u1}") callback:{v30}\n{v28}`));
                end);
            end;
        else
            local v31 = u4[u20];
            u4[u20] = "__dead__";

            if typeof(v31) == "function" then
                task.spawn(v31);
            end;
        end;
    end;

    local function OnInstanceAdded(u32: userdata) -- Line: 145
        -- upvalues: u6 (ref), u4 (copy), u5 (copy), u3 (copy), u2 (copy), u1 (copy)
        if not u6.Connected then
            return;
        end;

        if u4[u32] ~= nil then
            return;
        end;

        u4[u32] = "__dead__";
        u5[u32] = u32.AncestryChanged:Connect(function() -- Line: 155
            -- upvalues: u32 (copy), u3 (ref), u4 (ref), u2 (ref), u1 (ref)
            local u33 = u32;
            local v34;

            if u3 == nil then
                v34 = true;
            else
                v34 = false;

                for _, v in u3 do
                    if u33:IsDescendantOf(v) then
                        v34 = true;
                        break;
                    end;
                end;
            end;

            if v34 then
                if u4[u33] == "__dead__" then
                    u4[u33] = "__inflight__";
                    task.spawn(function() -- Line: 82
                        -- upvalues: u4 (ref), u33 (copy), u3 (ref), u2 (ref), u1 (ref)
                        if u4[u33] ~= "__inflight__" then
                            return;
                        end;

                        local v35 = u33;
                        local v36;

                        if u3 == nil then
                            v36 = true;
                        else
                            v36 = false;

                            for _, v in u3 do
                                if v35:IsDescendantOf(v) then
                                    v36 = true;
                                    break;
                                end;
                            end;
                        end;

                        if not v36 then
                            u4[u33] = "__dead__";

                            return;
                        end;

                        local v40, v41 = xpcall(function(p37: userdata) -- Line: 94
                            -- upvalues: u2 (ref)
                            local v38 = u2(p37);

                            if v38 ~= nil then
                                local v39 = typeof(v38) == "function";
                                assert(v39, "callback must return a function or nil");
                            end;

                            return v38;
                        end, debug.traceback, u33);

                        if v40 then
                            if u4[u33] == "__inflight__" then
                                u4[u33] = v41;
                            elseif v41 ~= nil then
                                task.spawn(v41);

                                return;
                            end;

                            return;
                        end;

                        local v42 = string.split(v41, "\n")[1];
                        local string_find_ret = string.find(v42, ": ");
                        local v43 = not string_find_ret and "" or v42:sub(string_find_ret + 1);
                        warn((`error while calling observeTag("{u1}") callback:{v43}\n{v41}`));
                    end);
                end;
            else
                local v44 = u4[u33];
                u4[u33] = "__dead__";

                if typeof(v44) == "function" then
                    task.spawn(v44);
                end;
            end;
        end);
        local v45;

        if u3 == nil then
            v45 = true;
        else
            v45 = false;

            for _, v in u3 do
                if u32:IsDescendantOf(v) then
                    v45 = true;
                    break;
                end;
            end;
        end;

        if v45 then
            if u4[u32] == "__dead__" then
                u4[u32] = "__inflight__";
                task.spawn(function() -- Line: 82
                    -- upvalues: u4 (ref), u32 (copy), u3 (ref), u2 (ref), u1 (ref)
                    if u4[u32] ~= "__inflight__" then
                        return;
                    end;

                    local v46 = u32;
                    local v47;

                    if u3 == nil then
                        v47 = true;
                    else
                        v47 = false;

                        for _, v in u3 do
                            if v46:IsDescendantOf(v) then
                                v47 = true;
                                break;
                            end;
                        end;
                    end;

                    if not v47 then
                        u4[u32] = "__dead__";

                        return;
                    end;

                    local v51, v52 = xpcall(function(p48: userdata) -- Line: 94
                        -- upvalues: u2 (ref)
                        local v49 = u2(p48);

                        if v49 ~= nil then
                            local v50 = typeof(v49) == "function";
                            assert(v50, "callback must return a function or nil");
                        end;

                        return v49;
                    end, debug.traceback, u32);

                    if v51 then
                        if u4[u32] == "__inflight__" then
                            u4[u32] = v52;
                        elseif v52 ~= nil then
                            task.spawn(v52);

                            return;
                        end;

                        return;
                    end;

                    local v53 = string.split(v52, "\n")[1];
                    local string_find_ret = string.find(v53, ": ");
                    local v54 = not string_find_ret and "" or v53:sub(string_find_ret + 1);
                    warn((`error while calling observeTag("{u1}") callback:{v54}\n{v52}`));
                end);
            end;
        else
            local v55 = u4[u32];
            u4[u32] = "__dead__";

            if typeof(v55) == "function" then
                task.spawn(v55);
            end;
        end;
    end;

    u6 = CollectionService:GetInstanceAddedSignal(u1):Connect(OnInstanceAdded);
    local u59 = CollectionService:GetInstanceRemovedSignal(u1):Connect(function(p56: userdata) -- Line: 161, Name: OnInstanceRemoved
        -- upvalues: u4 (copy), u5 (copy)
        local v57 = u4[p56];
        u4[p56] = "__dead__";

        if typeof(v57) == "function" then
            task.spawn(v57);
        end;

        local v58 = u5[p56];

        if v58 then
            v58:Disconnect();
            u5[p56] = nil;
        end;

        u4[p56] = nil;
    end);

    for _, v in CollectionService:GetTagged(u1) do
        task.defer(OnInstanceAdded, v);
    end;

    return function() -- Line: 183
        -- upvalues: u6 (ref), u59 (ref), u4 (copy), u5 (copy)
        u6:Disconnect();
        u59:Disconnect();
        local v60 = next(u4);

        while v60 do
            local v61 = u4[v60];
            u4[v60] = "__dead__";

            if typeof(v61) == "function" then
                task.spawn(v61);
            end;

            local v62 = u5[v60];

            if v62 then
                v62:Disconnect();
                u5[v60] = nil;
            end;

            u4[v60] = nil;
            v60 = next(u4);
        end;
    end;
end;

return observeTag;