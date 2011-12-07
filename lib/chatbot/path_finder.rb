# to do

# findpath (start,finish) ...
# verbalizePath (path) - constructs a fitting verbalization for a given path
# Graph class less verbose
#
# (verbalizepath macht wahrscheinlich eine (noch genauere?) Typbestimmung der Knoten nötig)


require 'readline'

module Chatbot

class PathFinder

# PathFinder wandelt den gespeicherten Campusgraphen in ein für den Algorithmus verwertbares Format um (buildgraph),
# ruft den Shortest-Path-Algorithmus des Graphen auf, um einen Pfad aus Knotennamen und ein Gewicht zu erhalten (findpath) und
# setzt diesen Pfad in eine passende natürlichsprachliche Beschreibung um (verbalizepath)


  def initialize(filepath)
    @campus = Graph.new
    build_graph(filepath)
  end

  def build_graph(filepath)
    # de-serialize given graph and build a Graph-instance
    file = File.open(filepath)

    file.each { |line|
      #print line
      firstnode = line.match(/from="(.*)" to/)
      secondnode = line.match(/to="(.*)" weight/)
      weight = line.match(/weight="(.*)"\/>/)
      if firstnode
        if secondnode
          if weight
            #puts "first: "+firstnode[1]
            #puts "second: "+secondnode[1]
            #puts "weight: "+weight[1]
            @campus.add_edge(firstnode[1],secondnode[1],Float(weight[1]))
          end
        end 
      end
    }
    #@campus.shownodes()	
  end

  def find_path(start,finish)
    # takes start and destination nodes, returns a path and a weight
    # maybe (?) save computed start-nodes and their path-weights for further use
    @campus.shortest_path(start,finish)
    
  end

  def verbalize_path()
    # takes a path, returns a natural-language-description of given path
  end

end




# implementation of dijkstra's algorithm, by "dennis" from DZone-Snippets: http://snippets.dzone.com/posts/show/7331

class Graph

# Graph realisiert den Graphen als Datenstruktur und stellt die möglichen Operationen
# (shortest_path ist ergänzt, shortest_paths kann wahrscheinlich weg ... in jedem Fall muss aber sowieso dijkstra(s) zuerst
# laufen, das wäre vielleicht besser ausgelagert (zB in findpath oder bereits beim Aufbauen))
# (andererseits muss dijkstra unter Umständen für jeden Startknoten neu laufen ... bin mal gespannt auf die Rechenzeit.)

  # Constructor
  def initialize
    @g = {} # the graph // {node => { edge1 => weight, edge2 => weight}, node2 => ...
    @nodes = Array.new
    @INFINITY = 1 << 64
  end

  def add_edge(s,t,w) # s= source, t= target, w= weight
    if (not @g.has_key?(s))
      @g[s] = {t=>w}
    else
      @g[s][t] = w
    end

    # Begin code for non directed graph (inserts the other edge too)
    if (not @g.has_key?(t))
      @g[t] = {s=>w}
    else
      @g[t][s] = w
    end
    # End code for non directed graph (ie. deleteme if you want it directed)
    
    if (not @nodes.include?(s))
      @nodes << s
    end
    if (not @nodes.include?(t))
      @nodes << t
    end
  end

  def shownodes()
    puts "my nodes :"
    puts @nodes
  end
	
  # based of wikipedia's pseudocode: http://en.wikipedia.org/wiki/Dijkstra's_algorithm

  def dijkstra(s)
    @d = {}
    @prev = {}

    @nodes.each do |i|
      @d[i] = @INFINITY
      @prev[i] = -1
    end

    @d[s] = 0
    q = @nodes.compact
    
    while (q.size > 0)
      u = nil;
      q.each do |min|
        if (not u) or (@d[min] and @d[min] < @d[u])
          u = min
        end 
      end
      if (@d[u] == @INFINITY)
        break
      end
      q = q - [u]
      g[u].keys.each do |v|
        alt = @d[u] + @g[u][v]
        if (alt < @d[v])
          @d[v] = alt
          @prev[v]  = u
        end
      end
    end
  end

  # To print the full shortest route to a node

  def print_path(dest)
    if @prev[dest] != -1
      print_path @prev[dest]
    end
    print ">#{dest}"
  end

# Gets all shortests paths using dijkstra

  def shortest_paths(s)
    @source = s
    dijkstra s
    puts "Source: #{@source}"
    @nodes.each do |dest|
      puts "\nTarget: #{dest}"
      print_path dest
      if @d[dest] != @INFINITY
        puts "\nDistance: #{@d[dest]}"
      else
        puts "\nNO PATH"
      end
    end
  end


  def shortest_path(s,d)
    @source = s
    @dest = d
    dijkstra s
    puts "Source: #{@source}"
    puts "\nTarget: #{@dest}"
    print_path @dest
    if @d[@dest] != @INFINITY
      puts "\nDistance: #{@d[@dest]}"
    else
      puts "\nNO PATH"
    end
  end

end

end