local RankModel = class("RankModel")

function RankModel:ctor(nickname, score)
    self.nickname = nickname
    self.score = score
end

function RankModel:data2Json()
    local rankModel = {
        nickname = self.nickname,
        score = self.score
    }
    return rankModel
end

function RankModel:json2Data(rankModel)
    self.nickname = rankModel.nickname
    self.score = rankModel.score
end

-- 降序
function RankModel.cmp(r1, r2)
    return r1.score > r2.score
end

return RankModel
