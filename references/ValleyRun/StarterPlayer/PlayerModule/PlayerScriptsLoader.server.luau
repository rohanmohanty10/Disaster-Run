 

 

if require(script.Parent:WaitForChild("CommonUtils")).get("FlagUtil").getUserFlag("UserControlModuleEnabledAPI") then
    require(script.Parent:WaitForChild("PlayerModuleInternal")).new():start();

    return;
end;

require(script.Parent);