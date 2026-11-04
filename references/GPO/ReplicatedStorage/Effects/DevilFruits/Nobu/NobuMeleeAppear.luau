 

local v1 = {}
local u2 = game:GetService("TweenService")
function v1.start(_, u3, u4) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u3.root.Position) then
        local u5 = TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
        local function u9(p6) --[[ Line: 12 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u2
                [3] = u5
            --]]
            for _, v7 in u3.Model[p6]:GetChildren() do
                local v8 = v7.Mesh
                u2:Create(v8, u5, {
                    ["Scale"] = v8:GetAttribute("InitialScale")
                }):Play()
            end
        end
        spawn(function() --[[ Line: 20 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u3
                [3] = u9
            --]]
            if u4 then
                local v10 = u3.Model.Handle.HandleShaft
                v10.Sparkles:Emit(1)
                v10.Waves:Emit(2)
                _G.PlaySound(v10, script.Appear)
                _G.PlaySound(v10, script.Pop)
                u9("Handle")
                task.wait(0.05)
                u3.Model.Pole.Main.AirWave:Emit(2)
                u3.Model.Pole.Main.Sparkles:Emit(1)
                _G.PlaySound(u3.Model.Pole.Main, script.Pop, {
                    ["PlaybackSpeed"] = 0.7
                })
                u9("Pole")
                task.wait(0.07)
                _G.PlaySound(u3.Model.Ends.Head, script.Pop, {
                    ["PlaybackSpeed"] = 0.8
                })
                _G.PlaySound(u3.Model.Ends.Head, script.FinishDoll)
                u3.Model.Ends.Head.FillStar:Emit(2)
                u3.Model.Ends.Head.HollowStar:Emit(6)
                u9("Ends")
            else
                local v11 = u3.Model.Handle.HandleShaft
                v11.Sparkles:Emit(2)
                v11.Waves:Emit(4)
                _G.PlaySound(v11, script.Appear)
                _G.PlaySound(v11, script.Pop)
                u9("Handle")
                task.wait(0.05)
                u3.Model.Pole.Main.AirWave:Emit(2)
                u3.Model.Pole.Main.Sparkles:Emit(1)
                _G.PlaySound(u3.Model.Pole.Main, script.Pop, {
                    ["PlaybackSpeed"] = 0.7
                })
                u9("Pole")
            end
        end)
    end
end
return v1