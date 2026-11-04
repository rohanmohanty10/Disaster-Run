 

return function(p1, p2, p3) --[[ Line: 4 ]]
    if not p1 then
        error(("Warp: %*"):format(p2), p3 or 2)
    end
end