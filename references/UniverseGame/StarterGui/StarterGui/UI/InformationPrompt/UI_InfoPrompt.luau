  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(u1) -- Line: 15
    -- upvalues: ReplicatedStorage (copy)
    require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
    local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Parent = script.Parent;
    local PromptFrame = Parent.PromptFrame;
    local Actions = PromptFrame.Actions;
    require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
    require(ReplicatedStorage.ReplicatedModules.Types);
    require(PathShortcuts.KnitPath.Trove);
    local Infos = require(script.Infos);
    local u2 = Fusion.Value(nil);
    local u3 = Fusion.Value(1);
    local u6 = Fusion.Computed(function() -- Line: 32
        -- upvalues: u2 (copy), u3 (copy)
        local v4 = u2:get();
        local v5 = u3:get();

        if v4 == nil then
            return nil;
        end;

        return v4.Pages[math.clamp(v5, 1, #v4.Pages)];
    end);
    Fusion.Observer(u2):onChange(function() -- Line: 40
        -- upvalues: u3 (copy)
        u3:set(1);
    end);

    local function Close() -- Line: 44
        -- upvalues: u2 (copy)
        u2:set(nil);
    end;

    Fusion.Hydrate(PromptFrame.Title)({
        Text = Fusion.Computed(function() -- Line: 72
            -- upvalues: u2 (copy), u6 (copy)
            local v7 = u2:get();
            local v8 = u6:get();

            return not (v8 and v8.Title) and (v7 and (v7.Title or "-") or "-") or v8.Title;
        end)
    });
    Fusion.Hydrate(PromptFrame.Graphic)({
        Image = Fusion.Computed(function() -- Line: 83
            -- upvalues: u6 (copy)
            local v9 = u6:get();

            return v9 and (v9.Image or "") or "";
        end)
    });
    Fusion.Hydrate(PromptFrame.DescriptionFrame.Description)({
        Text = Fusion.Computed(function() -- Line: 90
            -- upvalues: u6 (copy)
            local v10 = u6:get();

            return v10 and (v10.Text or "") or "";
        end)
    });
    Fusion.Hydrate(Actions.PageLabel)({
        Text = Fusion.Computed(function() -- Line: 97
            -- upvalues: u2 (copy), u3 (copy)
            local v11 = u2:get();

            return `{u3:get()} / {v11 and #v11.Pages or 1}`;
        end)
    });
    Fusion.Hydrate(Actions.Next)({
        Text = Fusion.Computed(function() -- Line: 107
            -- upvalues: u2 (copy), u3 (copy)
            local v12 = u2:get();

            return u3:get() >= (v12 and #v12.Pages or 1) and "Close" or "Next";
        end),

        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 48, Name: NextPage
            -- upvalues: u2 (copy), u3 (copy), u1 (copy)
            local v13 = u2:get();
            local v14 = u3:get();
            local v15 = v13 and #v13.Pages or 1;

            if v15 < v14 + 1 then
                u2:set(nil);
            else
                u3:set((math.clamp(v14 + 1, 1, v15)));
            end;

            u1:PlaySound("Click");
        end
    });
    Fusion.Hydrate(Actions.Back)({
        Visible = Fusion.Computed(function() -- Line: 119
            -- upvalues: u3 (copy)
            return u3:get() > 1;
        end),

        [Fusion.OnEvent("MouseButton1Click")] = function() -- Line: 63, Name: PreviousPage
            -- upvalues: u3 (copy), u1 (copy)
            local v16 = u3:get();
            u3:set((math.clamp(v16 - 1, 1, v16)));
            u1:PlaySound("Click");
        end
    });
    Fusion.Hydrate(Parent)({
        Visible = Fusion.Computed(function() -- Line: 127
            -- upvalues: u2 (copy)
            return u2:get() ~= nil;
        end),
        BackgroundTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 130
            -- upvalues: u2 (copy)
            return u2:get() == nil and 1 or 0.2;
        end), 25, 0.8)
    });

    function u1.ShowInformationPrompt(p17, p18) -- Line: 135
        -- upvalues: Infos (copy), u2 (copy)
        if typeof(p18) == "string" and Infos[p18] then
            u2:set(Infos[p18]);

            return;
        end;

        if typeof(p18) == "table" then
            u2:set(p18);
        end;
    end;
end;