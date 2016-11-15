require 'pry'

patches = [
    "@@ -22,3 +22,5 @@ waka waka\n lololo\n one test\n multiple lines added\n+muliple lines added again\n+line 2",
    "@@ -17,5 +17,3 @@ start, stop\n start, stop\n again\n labels\n-with different auth\n-pull request without 2FA",
    "@@ -14,6 +14,6 @@ contents\n empty\n enhance, enhance\n start, stop\n-start, stop\n+start, stop, don't start, don't stop\n again\n labels are replaced again and again"
]

def create_response(diff)
    response = {}
    # binding.pry
    cleaned = diff.gsub("+", '').gsub('-', '').split(' ')
    response = {
      removed: {
        from: cleaned[0].split(',')[0],
        to: cleaned[0].split(',')[1]
      },
      added: {
        from: cleaned[1].split(',')[0],
        to: cleaned[1].split(',')[1]
      }
    }
end

def add_lines(response, new_lines)
    new_lines = new_lines.slice(1, new_lines.length)
    binding.pry
end

def extract_lines(patch)
    response = {}
    new_lines = []
    lines = patch.split('@@')
    lines = lines.slice(1, lines.length)
    lines[0] = lines[0].strip
    lines[1] = lines[1].strip
    lines.each {|line| new_lines << line.split(/\r?\n/)}
    new_lines = new_lines.flatten
    # binding.pry
    response = create_response(new_lines[0])
    response = add_lines(response, new_lines)
    # response['diff']
end

patches.each do |patch|
    lines = extract_lines(patch)
    puts lines.inspect
end
