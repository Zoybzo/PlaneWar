---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Zoybzo.
--- DateTime: 2022-05-26 11:20
---
local BaseModel = class("BaseModel")

--- constructor
function BaseModel:ctor(name)
    self.updateList = {} --view
    self.name = name
    self:init()
end

---
function BaseModel:registerView(view)
    self.updateList[view.name] = view
    return self
end

---
function BaseModel:removeViewBind(viewName)
    -- 应该不需要判断，直接nil就成
    self.updateList[viewName] = nil
    --if self.updateList[viewName] ~= nil then
    --    self.updateList[viewName] = nil
    --end
end

---
function BaseModel:init()
    Log.i("BaseModel init")
end

---
function BaseModel:update()
    for _, view in pairs(self.updateList) do
        view.modelUpdate(self)
    end
end

return BaseModel