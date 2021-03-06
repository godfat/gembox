
module KeyDiff
  module_function
  def diff a, b, delimiter = '.', prefix = '', flip = true
    result = a.keys.map{ |key|
      if b.has_key?(key)
        if a[key].kind_of?(Hash) && b[key].kind_of?(Hash)
          KeyDiff.diff(a[key], b[key], delimiter, "#{prefix}#{key}#{delimiter}", false)
        end
      else
        KeyDiff.map_missing(a, [key], delimiter, prefix).flatten
      end
    }.compact.flatten.sort

    if flip
      [KeyDiff.diff(b, a, delimiter, prefix, false), result]
    else
      result
    end
  end

  def map_missing hash, missings = hash.keys, delimiter = '.', prefix = nil
    missings.map{ |mis|
      if (value = hash[mis]).kind_of?(Hash)
        KeyDiff.map_missing(value, value.keys, delimiter, "#{prefix}#{mis}#{delimiter}")
      else # String, Array, etc.
        "#{prefix}#{mis}: #{value.inspect}"
      end
    }
  end
end
