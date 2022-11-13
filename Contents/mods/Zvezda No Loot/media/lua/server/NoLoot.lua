
local function OnPostDistributionMerge()
  print("Deleting all Distributions")
	ClearAllDistributionItems(SuburbsDistributions, true)
  ClearAllDistributionItems(Distributions, true)
  ClearAllDistributionItems(ProceduralDistributions, true)
end

Events.OnPostDistributionMerge.Add(OnPostDistributionMerge)
