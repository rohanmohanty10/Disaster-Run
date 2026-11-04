 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local trove = require(ReplicatedStorage.forum.trove);
local v1 = {};

local function set_gui_enabled(p2: userdata, p3: boolean) -- Line: 8
    if p2:IsA("ScreenGui") then
        p2.Enabled = p3;

        return;
    end;

    if p2:IsA("GuiObject") then
        p2.Visible = p3;
    end;
end;

local function ensure_rematch_gui(p4: userdata, p5: any) -- Line: 16
    -- upvalues: ReplicatedStorage (copy)
    local Rematch = p4:FindFirstChild("Rematch");

    if Rematch and Rematch:IsA("ScreenGui") then
        return Rematch;
    end;

    local RematchUI = ReplicatedStorage:WaitForChild("RematchUI", 30);

    if not RematchUI then
        warn("[RankedRematch] ReplicatedStorage.RematchUI not found");

        return nil;
    end;

    local v6 = RematchUI:Clone();
    v6.Name = "Rematch";

    if v6:IsA("ScreenGui") then
        v6.ResetOnSpawn = false;
        v6.Enabled = false;
    end;

    v6.Parent = p4;
    p5:Add(v6);

    return v6;
end;

local function resolve_rematch_frames(p7: userdata) -- Line: 39
    local Holder = p7:FindFirstChild("Holder");

    return Holder, Holder:FindFirstChild("Rematch"), Holder:FindFirstChild("Leave"), Holder:FindFirstChild("Amount", true);
end;

local function update_lobby_header(p8: userdata?, p9: number) -- Line: 47
    if not p8 then
        return;
    end;

    local Header = p8:FindFirstChild("Header");

    if Header and Header:IsA("TextLabel") then
        Header.Text = `Returning to lobby in {p9}s`;
    end;
end;

function v1.RankedRematch(u10) -- Line: 57
    -- upvalues: ReplicatedStorage (copy), trove (copy), soundUtil (copy), ensure_rematch_gui (copy), resolve_rematch_frames (copy)
    if not ReplicatedStorage.Ranked.Value then
        return;
    end;

    local RankedRematch = ReplicatedStorage:WaitForChild("RankedRematch", 120);

    if not (RankedRematch and RankedRematch:IsA("RemoteEvent")) then
        return;
    end;

    local playerGui = u10.playerGui;
    local u11 = trove.new();
    local u12 = false;
    local u13 = 30;

    local function bind_vote_buttons(p14: userdata?, p15: userdata?) -- Line: 72
        -- upvalues: u12 (ref), u11 (copy), soundUtil (ref), ReplicatedStorage (ref), RankedRematch (copy)
        if u12 then
            return;
        end;

        u12 = true;

        local function bind(p16: userdata?, u17: string) -- Line: 77
            -- upvalues: u11 (ref), soundUtil (ref), ReplicatedStorage (ref), RankedRematch (ref)
            if not p16 then
                return;
            end;

            local Button = p16:FindFirstChild("Button", true);

            if Button and Button:IsA("GuiButton") then
                u11:Connect(Button.MouseButton1Click, function() -- Line: 83
                    -- upvalues: soundUtil (ref), ReplicatedStorage (ref), RankedRematch (ref), u17 (copy)
                    soundUtil:play(ReplicatedStorage.Resources.click, "default");
                    RankedRematch:FireServer(u17);
                end);
            end;
        end;

        bind(p15, "Leave");
        bind(p14, "Rematch");
    end;

    local function hide_rematch(p18: userdata?, p19: userdata?) -- Line: 93
        if p19 and p19:IsA("CanvasGroup") then
            p19.Visible = false;
        end;

        if p18 then
            if p18:IsA("ScreenGui") then
                p18.Enabled = false;

                return;
            end;

            if p18:IsA("GuiObject") then
                p18.Visible = false;
            end;
        end;
    end;

    local function show_vote(p20: userdata?, p21: userdata?, p22: userdata?, p23: userdata?, p24: userdata?, p25: number, p26: number) -- Line: 102
        -- upvalues: u12 (ref), u11 (copy), soundUtil (ref), ReplicatedStorage (ref), RankedRematch (copy), u13 (ref)
        if not u12 then
            u12 = true;

            local function v29(p27: userdata?, u28: string) -- Line: 77
                -- upvalues: u11 (ref), soundUtil (ref), ReplicatedStorage (ref), RankedRematch (ref)
                if not p27 then
                    return;
                end;

                local Button = p27:FindFirstChild("Button", true);

                if Button and Button:IsA("GuiButton") then
                    u11:Connect(Button.MouseButton1Click, function() -- Line: 83
                        -- upvalues: soundUtil (ref), ReplicatedStorage (ref), RankedRematch (ref), u28 (copy)
                        soundUtil:play(ReplicatedStorage.Resources.click, "default");
                        RankedRematch:FireServer(u28);
                    end);
                end;
            end;

            v29(p23, "Leave");
            v29(p22, "Rematch");
        end;

        if p20 then
            if p20:IsA("ScreenGui") then
                p20.Enabled = true;
            elseif p20:IsA("GuiObject") then
                p20.Visible = true;
            end;
        end;

        if p21 and p21:IsA("CanvasGroup") then
            p21.Visible = true;
            p21.GroupTransparency = 0;
        end;

        if p22 and p22:IsA("GuiObject") then
            p22.Visible = true;
        end;

        if p23 and p23:IsA("GuiObject") then
            p23.Visible = true;
        end;

        if p24 then
            p24.Text = `{p25}/{p26}`;
        end;

        local v30 = u13;

        if not p21 then
            return;
        end;

        local Header = p21:FindFirstChild("Header");

        if Header and Header:IsA("TextLabel") then
            Header.Text = `Returning to lobby in {v30}s`;
        end;
    end;

    u11:Connect(RankedRematch.OnClientEvent, function(p31: string, ...) -- Line: 131
        -- upvalues: u10 (copy), ensure_rematch_gui (ref), playerGui (copy), u11 (copy), show_vote (copy), u13 (ref), resolve_rematch_frames (ref)
        if p31 ~= "Begin" then
            if p31 == "VoteTimer" then
                local v32 = ...;
                u13 = v32;
                local Rematch = playerGui:FindFirstChild("Rematch");

                if not (Rematch and Rematch:IsA("ScreenGui")) then
                    return;
                end;

                local v33 = select(1, resolve_rematch_frames(Rematch));

                if not v33 then
                    return;
                end;

                local Header = v33:FindFirstChild("Header");

                if Header and Header:IsA("TextLabel") then
                    Header.Text = `Returning to lobby in {v32}s`;

                    return;
                end;
            elseif p31 == "VoteUpdate" then
                local v34, v35 = ...;
                local Rematch = playerGui:FindFirstChild("Rematch");

                if not (Rematch and Rematch:IsA("ScreenGui")) then
                    return;
                end;

                local Holder = Rematch:FindFirstChild("Holder");
                Holder:FindFirstChild("Rematch");
                Holder:FindFirstChild("Leave");
                local Amount = Holder:FindFirstChild("Amount", true);

                if Amount then
                    Amount.Text = `{v34}/{v35}`;

                    return;
                end;
            else
                if p31 == "RematchStart" then
                    local Rematch = playerGui:FindFirstChild("Rematch");

                    if Rematch and Rematch:IsA("ScreenGui") then
                        local v36 = select(1, resolve_rematch_frames(Rematch));

                        if v36 and v36:IsA("CanvasGroup") then
                            v36.Visible = false;
                        end;

                        if Rematch then
                            if Rematch:IsA("ScreenGui") then
                                Rematch.Enabled = false;
                            elseif Rematch:IsA("GuiObject") then
                                Rematch.Visible = false;
                            end;
                        end;
                    end;

                    u10:destroyContainer();

                    return;
                end;

                if p31 == "Close" then
                    local Rematch = playerGui:FindFirstChild("Rematch");

                    if Rematch and Rematch:IsA("ScreenGui") then
                        local v37 = select(1, resolve_rematch_frames(Rematch));

                        if v37 and v37:IsA("CanvasGroup") then
                            v37.Visible = false;
                        end;

                        if Rematch then
                            if Rematch:IsA("ScreenGui") then
                                Rematch.Enabled = false;
                            elseif Rematch:IsA("GuiObject") then
                                Rematch.Visible = false;
                            end;
                        end;
                    end;

                    u10.rematch_menu_locked = false;
                    task.defer(function() -- Line: 175
                        -- upvalues: u10 (ref)
                        u10:applyRematchLobbyLock();
                    end);
                    u11:Destroy();
                end;
            end;

            return;
        end;

        local v38 = ...;
        u10.rematch_menu_locked = true;
        u10:applyRematchLobbyLock();
        local v39 = ensure_rematch_gui(playerGui, u11);

        if not v39 then
            return;
        end;

        local Holder = v39:FindFirstChild("Holder");
        show_vote(v39, Holder, Holder:FindFirstChild("Rematch"), Holder:FindFirstChild("Leave"), Holder:FindFirstChild("Amount", true), 0, v38);
    end);
end;

return v1;