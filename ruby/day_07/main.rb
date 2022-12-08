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
  attr_reader :size

  def initialize(name, size, node_layer)
    @name = name
    @size = size.to_i
    @node_layer = node_layer
  end

  def find_dirs
    []
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

  def size
    @size ||= @children.values.map(&:size).sum
  end

  def find_dirs
    [self, @children.values.map(&:find_dirs)].flatten
  end

  def to_s
    row = ("  " * @node_layer) + "Dir #{@name} - Total size: #{size}"
    [row, @children.values.map(&:to_s)].flatten.join("\n")
  end
end

# Example node structure:
# Dir / - Total size: 48381165
#   Dir a - Total size: 94853
#     Dir e - Total size: 584
#       File i 584
#     File f 29116
#     File g 2557
#     File h.lst 62596
#   File b.txt 14848514
#   File c.dat 8504156
#   Dir d - Total size: 24933642
#     File j 4060174
#     File d.log 8033020
#     File d.ext 5626152
#     File k 7214296
def build_nodes
  root_node = DirNode.new('/', nil, 0)
  current_node = root_node

  read_input.each do |line|
    data = parse(line)
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
  # puts root_node
  puts (root_node.find_dirs.select {|node| node.size <= 100_000}.map(&:size).sum)
end

def part_2
  # total = 70_000_000
  # needed_for_update = 30_000_000
  # current = 50_216_456
  # current - (total - needed_for_update)

  target = 10_216_456

  root_node = build_nodes
  puts (root_node.find_dirs.select {|node| node.size >= target}.map(&:size).sort[0])
end

part_1
part_2