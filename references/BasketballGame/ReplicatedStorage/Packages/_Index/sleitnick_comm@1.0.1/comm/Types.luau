 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
-- Types
-- Stephen Leitnick
-- December 20, 2021

export type Args = {
	n: number,
	[any]: any,
}

export type FnBind = (Instance, ...any) -> ...any

export type ServerMiddlewareFn = (Instance, Args) -> (boolean, ...any)
export type ServerMiddleware = { ServerMiddlewareFn }

export type ClientMiddlewareFn = (Args) -> (boolean, ...any)
export type ClientMiddleware = { ClientMiddlewareFn }

return nil

]]

 

return nil;