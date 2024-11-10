-- probolem komiwojazera (Travelling Salesman Problem (TSP) using Reduced Matrix Method)
-- na podstawie https://www.geeksforgeeks.org/travelling-salesman-problem-tsp-using-reduced-matrix-method/?ref=rp
ra.tsp = ra.tsp or {
  max_distance = 10000000,
  points = {},
  graph = {},
  queue = {},
}

function ra.tsp:initialize()
  ra.tsp.points = {}
  ra.tsp.graph = {}
  ra.tsp.queue = {}
end

function ra.tsp:add(point)
  table.insert(ra.tsp.points, point)
  ra.tsp.graph[point] = {}
end

function ra.tsp:clear()
  ra.tsp.points = {}
  ra.tsp.graph = {}
  ra.tsp.queue = {}
end

function ra.tsp:add_distance(start_point, end_point, distance)
  assert(ra.tsp.graph[start_point] ~= nil)
  assert(end_point ~= nil)
  ra.tsp.graph[start_point][end_point] = distance
end

function ra.tsp:get_path()

 local graph = ra.tsp.graph
 local points = ra.tsp.points

local output = {}
 
local function copy_t(tbl)
    local t = {}
    for key, value in pairs(tbl) do
      t[key] = value
    end
    return t
end

local function permutation(a, n)
    if n == 0 then

         table.insert(output,copy_t(a))
    else
        for i = 1, n do
            a[i], a[n] = a[n], a[i]                     
            permutation(a, n - 1)
            a[i], a[n] = a[n], a[i]
        end
    end
end
  permutation(points,#points,1)
  display(output)
  local function get_min_dest(point)
    local min = ra.tsp.max_distance
    for k, v in pairs(ra.tsp.graph) do
    table.sort(v)
      display(k, v)
        
       -- if v[1] < min then
      --    min = v[1]
      --  end
    end
    return min
  end
  
--  for _, v in pairs(ra.tsp.points) do
 --    display("id: ", v, "min: ", get_min_dest(v))
  --end  
end