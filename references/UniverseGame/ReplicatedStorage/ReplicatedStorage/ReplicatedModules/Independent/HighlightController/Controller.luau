  

 

local u1 = {};
u1.__index = u1;
local Janitor = require(script.Parent.Janitor);
local Stack = require(script.Parent.Stack);
local Constants = require(script.Constants);
local TableUtil = require(script.Parent.Parent.Parent.KnitPackage.TableUtil);
local TweenService = game:GetService("TweenService");

function u1.new(p2) -- Line: 11
    -- upvalues: u1 (copy), Janitor (copy), Stack (copy), Constants (copy)
    local u3 = setmetatable({}, u1);
    u3.Object = p2;
    u3.Janitor = Janitor.new();
    u3.Janitor:LinkToInstance(u3.Object);
    u3.Janitor:Add(function() -- Line: 18
        -- upvalues: u3 (copy)
        if u3.Tween then
            u3.Tween:Destroy();
        end;

        u3:Destroy();
    end);
    u3.Stack = u3.Janitor:Add(Stack.new());
    u3.Current = nil;
    u3.Highlight = u3.Janitor:Add(Instance.new("Highlight"));
    u3.Highlight.Name = "HighlightControllerObject";
    u3.Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    u3.Highlight.Enabled = true;

    for i, v in pairs(Constants.BASE_HIGHLIGHT.Properties) do
        u3.Highlight[i] = v;
    end;

    u3.Highlight.Parent = p2;
    u3.Tween = nil;

    return u3;
end;

function u1.Add(p4, ...) -- Line: 45
    p4.Stack:Add(...);
    p4:Update();
end;

function u1.Remove(p5, ...) -- Line: 50
    p5.Stack:Remove(...);
    p5:Update();
end;

function u1.Get(p6, ...) -- Line: 55
    p6.Stack:Get(...);
end;

function u1.GetAll(p7, ...) -- Line: 59
    p7.Stack:GetAll(...);
end;

function u1.Update(u8) -- Line: 63
    -- upvalues: TableUtil (copy), Constants (copy), TweenService (copy)
    local v9 = {};

    for _, v in pairs(u8.Stack:GetAll()) do
        v9 = TableUtil.Reconcile(v9, v.Value);
    end;

    local v10 = TableUtil.Reconcile(v9, Constants.BASE_HIGHLIGHT);

    if u8.Current ~= v10 then
        local Properties = v10.Properties;
        local TweenInfo = v10.TweenInfo;

        if Properties then
            if Properties.OutlineTransparency and Properties.OutlineTransparency < 1 or Properties.FillTransparency and Properties.FillTransparency < 1 then
                u8.Highlight.Parent = u8.Object;
            end;

            if TweenInfo then
                local v11 = {};
                local v12 = {};

                for i, v in pairs(Properties) do
                    if typeof(v) == "Color3" or typeof(v) == "number" then
                        v11[i] = v;
                    else
                        v12[i] = v;
                    end;
                end;

                for i, v in pairs(v12) do
                    u8.Highlight[i] = v;
                end;

                if next(v11) then
                    if u8.Tween then
                        u8.Tween:Cancel();
                        u8.Tween:Destroy();
                    end;

                    TweenService:Create(u8.Highlight, TweenInfo, v11);
                    local u13 = TweenService:Create(u8.Highlight, TweenInfo, v11);
                    u13:Play();
                    local u14 = nil;
                    u14 = u13.Completed:Connect(function(p15) -- Line: 114
                        -- upvalues: u14 (ref), u8 (copy), u13 (ref)
                        u14:Disconnect();

                        if p15 == Enum.PlaybackState.Completed and (u8.Highlight.OutlineTransparency >= 1 and u8.Highlight.FillTransparency >= 1) then
                            u8.Highlight.Parent = nil;
                        end;

                        u13:Destroy();
                    end);
                    u8.Tween = u13;
                end;
            else
                for i, v in pairs(Properties) do
                    u8.Highlight[i] = v;
                end;

                if u8.Highlight.OutlineTransparency >= 1 and u8.Highlight.FillTransparency >= 1 then
                    u8.Highlight.Parent = nil;
                end;
            end;
        end;
    end;
end;

function u1.Destroy(p16) -- Line: 131
    if getmetatable(p16) and getmetatable(p16.Janitor) then
        p16.Janitor:Destroy();
    end;

    setmetatable(p16, nil);
end;

return u1;