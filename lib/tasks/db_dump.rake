namespace :db_dump do
  desc 'Dump the tables for a particular date (usage: rake db_dump:to_json[date])'
  task :to_json, ['date'] => :environment do |task, args|
    trends = Trend.where(collected: args[:date])
    trend_ids = trends.map {|t| t.id}
    nodes = []
    trend_ids.each {|tid| nodes.concat(Node.where(trend_id: tid))}
    node_ids = nodes.map {|n| n.id}
    nodelinks = []
    node_ids.each {|nid| nodelinks.concat(NodeLink.where(node_id: nid))}
    link_ids = nodelinks.map{|nl| nl.link_id}.sort.uniq
    links = []
    link_ids.each {|lid| links.push(Link.find(lid))}
    puts [trends,nodes,links,nodelinks].to_json
  end
end
