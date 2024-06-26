require 'fileutils'
require 'xcodeproj'

# 读取类名映射文件
def read_class_mappings(file_path)
  mappings = {}
  File.readlines(file_path).each do |line|
    old_name, new_name = line.strip.split
    mappings[old_name] = new_name
  end
  mappings
end

# 递归修改文件内容并重命名文件
def replace_class_names_in_file(file_path, mappings)
  text = File.read(file_path)
  file_updated = false
  filename_updated = false
  new_file_path = file_path

  mappings.each do |old_name, new_name|
    if File.basename(file_path).include?(old_name)
      new_file_path = file_path.gsub(old_name, new_name)
      filename_updated = true
    end
    if text.gsub!(old_name, new_name)
      file_updated = true
    end
    
  end

  if file_updated
      puts "Updated new_file_path: #{new_file_path}"
      puts "Updated file_path: #{file_path}"
  end
  
  if filename_updated
      puts "Updated new_file_path: #{new_file_path}"
      puts "Updated file_path: #{file_path}"
  end
 
  # 如果文件名更新，重命名文件
  FileUtils.mv(file_path, new_file_path) if filename_updated
  # 如果文件内容更新，重写文件
  File.write(new_file_path, text) if file_updated

  

  return new_file_path
end

# 更新Xcode项目文件中的引用
def update_xcode_project_references(project_path, mappings)
  project_files = Dir.glob("#{project_path}/**/*.xcodeproj")
  project_files.each do |project_file|
    project = Xcodeproj::Project.open(project_file)
    project.files.each do |file|
      mappings.each do |old_name, new_name|
        if file.path.include?(old_name)
          file.path = file.path.gsub(old_name, new_name)
        end
      end
    end
    project.save
  end
end

# 遍历项目文件夹中的所有相关文件并更新
def update_project_files(project_path, mappings)
  files_to_rename = Dir.glob("#{project_path}/**/*.{h,m,mm,swift,pch,xib}")
  files_to_rename.each do |file|
    new_path = replace_class_names_in_file(file, mappings)
    file = new_path
  end
  update_xcode_project_references(project_path, mappings)
end

# 主函数
def main
  mappings_file = File.join(__dir__, 'renamed_classes.txt')  # 类名映射文件路径
  project_path = __dir__          # 项目文件夹路径

  # 读取映射
  mappings = read_class_mappings(mappings_file)

  # 更新项目文件
  update_project_files(project_path, mappings)
end

main
