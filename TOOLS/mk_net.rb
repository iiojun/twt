#!/usr/bin/ruby
# cat relation.tsv | ./mk_net

word_ary = []
freq_ary = []
node_set = []
node_color = {}
color_tbl = %w(khaki lemonchiffon aliceblue mistyrose coral goldenrod aquamarine lavender
  palegreen gold lightpink plum yellow lightcyan lavenderblush gainsboro
  yellowgreen lightsteelblue palegoldenrod lightskyblue greenyellow plum cornflowerblue)

th_val = 0.75
mthd = 'fdp'
title = 'topicmap'

STDIN.each {|line|
  (kw1,kw2,freq) = line.split(/\t/)
  word_ary.push(kw1) unless word_ary.include?(kw1)
  word_ary.push(kw2) unless word_ary.include?(kw2)
  if freq.to_f > th_val
    freq_ary.push(line)
    flag = false
    node_set.each {|x|
      if x.include?(kw1) && x.include?(kw2)
        flag = true
        break
      end
      len0 = x.length
      x.push(kw2) if x.include?(kw1) && !x.include?(kw2)
      x.push(kw1) if !x.include?(kw1) && x.include?(kw2)
      if len0 < x.length
        flag = true
        break
      end
    }
    node_set.push([kw1, kw2]) unless flag
  end 
}

def get_set(ary_of_ary, x)
  ret_ary = []
  ary_of_ary.each {|ary|
    ret_ary = ret_ary + ary if ary.include?(x)
  }
  return ret_ary
end

def delete_set(ary_of_ary, x)
  ary_of_ary.each {|ary|
    ary_of_ary.delete(ary) if ary.include?(x)
  }
end

freq_ary.each {|x|
  (kw1,kw2,freq) = x.split(/\t/)
  x1 = get_set(node_set, kw1)
  x2 = get_set(node_set, kw2)
  next if (x1 == x2)
  x3 = x1 | x2
  delete_set(node_set, kw1)
  delete_set(node_set, kw2)
  node_set.push(x3)
}

word_ary.map {|x| node_color[x] = 'white' }

node_set.each_with_index {|value,index|
  i = index % color_tbl.length
  value.map{|x| node_color[x] = color_tbl[i] }
}

print "graph \"#{title}\" {\n"
print " graph [\n    layout = #{mthd}\n  ];\n"

word_ary.each {|x|
  printf "  \"%s\" [ fontname = \"ヒラギノ丸ゴ\"; style = \"filled\"; fillcolor = \"%s\"; fontcolor = \"%s\" ];\n", x, node_color[x], 'black'
}

while (!freq_ary.empty?) do
  (f,t,prob) = freq_ary.shift.split(/\t/)
  printf "  \"%s\" -- \"%s\" [label = \"%4.2f\"];\n", f, t, prob
end

print "}\n"
