package.path = "../?.lua;" .. package.path
export test = (klass) -> v! for k, v in pairs(klass.__base) when string.find(k, "test$")