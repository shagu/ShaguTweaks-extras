local _G = ShaguTweaks.GetGlobalEnv()
local T = ShaguTweaks.T

local module = ShaguTweaks:register({
  title = T["Bag Search Bar"],
  description = T["Adds a search field to the bag which allows you to search bag, keyring and bank slots."],
  expansions = { ["vanilla"] = true, ["tbc"] = nil },
  maintainer = "@shagu (GitHub)",
  enabled = true,
})

module.enable = function(self)
  local search = CreateFrame("EditBox", "ShaguTweaksBagSearchBar", ContainerFrame1, "InputBoxTemplate")
  search:SetPoint("TOPRIGHT", ContainerFrame1, "TOPRIGHT", -10, -30)
  search:SetWidth(110)
  search:SetHeight(16)

  search:SetTextColor(1, 1, 1, .75)
  search:SetTextInsets(4, 18, 4, 4)
  search:SetAutoFocus(false)
  search:SetAlpha(.75)

  search.button = CreateFrame("Button", "ShaguTweaksBagSearchBarButton", search)
  search.button:EnableMouse(true)
  search.button:SetWidth(24)
  search.button:SetHeight(24)
  search.button:SetPoint("RIGHT", search, "RIGHT", 3, 0)

  search.icon = search.button:CreateTexture(nil, "OVERLAY")
  search.icon:SetAllPoints(search.button)

  ShaguTweaks.HookScript(ContainerFrame1, "OnShow", function()
    if this:GetID() == 0 then search:Show() else search:Hide() end
  end)

  local enable = function()
    search.icon:SetTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    search:SetAlpha(1)
    search:SetText("")
  end

  local disable = function()
    search.icon:SetTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
    search:SetAlpha(.75)
    search:SetText("")
  end

  local clear = function()
    search:ClearFocus()
    disable()
  end

  local query = function()
    local text = strlower(search:GetText())

    -- bag search
    for i = 1, 12 do
      local frame = _G["ContainerFrame"..i]
      if frame then
        local name = frame:GetName()
        local bag = frame:GetID()

        for j = 1, MAX_CONTAINER_ITEMS do
          local button = _G[name.."Item"..j]
          local texture = _G[button:GetName().."IconTexture"]

          if button then
            local slot = button and button:GetID()

            local link = GetContainerItemLink(bag, slot)
            button:SetAlpha(.25)
            texture:SetDesaturated(1)

            local item = link and string.sub(link, string.find(link, "%[")+1, string.find(link, "%]")-1) or ""
            if strfind(strlower(item), text, 1, true) then
              button:SetAlpha(1)
              texture:SetDesaturated(0)
            end
          end
        end
      end
    end

    -- bank search
    if BankFrame:IsVisible() then
      for i = 1, 28 do
        local button = _G["BankFrameItem"..i]
        local texture = _G[button:GetName().."IconTexture"]
        if button then
          local link = GetContainerItemLink(-1, i)
          button:SetAlpha(.25)
          texture:SetDesaturated(1)

          local item = link and string.sub(link, string.find(link, "%[")+1, string.find(link, "%]")-1) or ""
          if strfind(strlower(item), text, 1, true) then
            button:SetAlpha(1)
            texture:SetDesaturated(0)
          end
        end
      end
    end
  end

  search:SetScript("OnTextChanged", query)
  search:SetScript("OnEditFocusGained", enable)
  search:SetScript("OnEditFocusLost", disable)
  search:SetScript("OnTabPressed", clear)
  search.button:SetScript("OnClick", clear)

  clear()
end
