def read_input
  IO.readlines("input.txt").map(&:strip).tap do |lines|
    lines.shift # remove top `$ cd /`
  end
end

def parse(line)
  is_command = false
  is_ls = false
  is_cd = false
  cd_dir = nil
  dir_name = nil
  is_dir = false
  is_file = false
  file_name = nil
  file_size = nil

  chunks = line.split(/\s+/)
  if chunks[0] == '$'
    is_command = true
    is_ls = (chunks[1] == 'ls')
    is_cd = (chunks[1] == 'cd')
    if is_cd
      dir_name = chunks[2]
    end
  elsif chunks[0] == 'dir'
    is_dir = true
    dir_name = chunks[1]
  else
    is_file = true
    file_name = chunks[1]
    file_size = chunks[0]
  end

  {
    is_command: is_command,
    is_ls: is_ls,
    is_cd: is_cd,
    cd_dir: cd_dir,
    dir_name: dir_name,
    is_dir: is_dir,
    is_file: is_file,
    file_name: file_name,
    file_size: file_size
  }
end

class FileNode
  def initialize(name, size, node_layer)
    @name = name
    @size = size.to_i
    @node_layer = node_layer
  end

  def to_s
    ("  " * @node_layer) + "File #{@name} #{@size}"
  end
end

class DirNode
  attr_reader :name

  def initialize(name, parent_node, node_layer)
    @name = name
    @parent_node = parent_node
    @node_layer = node_layer
    @children = {}
  end

  def add_dir(dir_name)
    @children[dir_name] ||= DirNode.new(dir_name, self, @node_layer + 1)
  end

  def add_file(file_name, file_size)
    @children[file_name] ||= FileNode.new(file_name, file_size, @node_layer + 1)
  end

  def cd(dir_name)
    return @parent_node if dir_name == '..'

    @children[dir_name]
  end

  def to_s
    row = ("  " * @node_layer) + "Dir #{@name}"
    [row, @children.values.map(&:to_s)].flatten.join("\n")
  end
end


def build_nodes
  pp read_input
  root_node = DirNode.new('/', nil, 0)
  current_node = root_node

  read_input.each do |line|
    puts "********"
    pp line
    data = parse(line)
    pp data
    if data[:is_ls]
      # No op
    elsif data[:is_dir]
      current_node.add_dir(data[:dir_name])
    elsif data[:is_cd]
      current_node = current_node.cd(data[:dir_name])
    elsif data[:is_file]
      current_node.add_file(data[:file_name], data[:file_size])
    end
  end

  root_node
end

def part_1
  root_node = build_nodes
  puts "*" * 90

  puts root_node
end

part_1