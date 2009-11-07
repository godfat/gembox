
module HashDiff
  module_function
  def diff a, b, delimiter = '.', prefix = '', flip = true
    a.keys.map{ |key|
      if b.has_key?(key)
        if a[key].kind_of?(Hash) && b[key].kind_of?(Hash)
          HashDiff.diff(a[key], b[key], delimiter, "#{prefix}#{key}#{delimiter}", false)
        end
      else
        HashDiff.map_missing(a, [key], delimiter, prefix).flatten
      end
    }.compact.flatten + (flip ? HashDiff.diff(b, a, delimiter, prefix, false) : [])
  end

  def map_missing hash, missings = hash.keys, delimiter = '.', prefix = nil
    missings.map{ |mis|
      if (value = hash[mis]).kind_of?(Hash)
        HashDiff.map_missing(value, value.keys, delimiter, "#{prefix}#{mis}#{delimiter}")
      else # String, Array, etc.
        "#{prefix}#{mis}: #{value}"
      end
    }
  end
end
