return function(value, min1, max1, min2, max2)
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1)
end
