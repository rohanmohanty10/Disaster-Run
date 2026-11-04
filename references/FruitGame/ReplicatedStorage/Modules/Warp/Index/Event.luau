 

local v1 = game:GetService("RunService")
require(script.Parent.Type)
if v1:IsServer() then
    if not script:FindFirstChild("Reliable") then
        Instance.new("RemoteEvent", script).Name = "Reliable"
    end
    if not script:FindFirstChild("Unreliable") then
        Instance.new("UnreliableRemoteEvent", script).Name = "Unreliable"
    end
    if not script:FindFirstChild("Request") then
        Instance.new("RemoteEvent", script).Name = "Request"
    end
elseif not (script:FindFirstChild("Reliable") and (script:FindFirstChild("Unreliable") and script:FindFirstChild("Request"))) then
    repeat
        task.wait()
    until script:FindFirstChild("Reliable") and (script:FindFirstChild("Unreliable") and script:FindFirstChild("Request"))
end
return {
    ["Reliable"] = script.Reliable,
    ["Unreliable"] = script.Unreliable,
    ["Request"] = script.Request
}