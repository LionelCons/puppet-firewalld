require 'puppet'

Puppet::Type.type(:firewalld_direct_purge).provide :firewall_cmd do
  desc "Interact with firewall-cmd"


  commands :firewall_cmd => 'firewall-cmd'

  def exists?
    if @resource[:purge_direct_rules]
      true
    elsif @resource[:purge_direct_chains]
      true
    elsif @resource[:purge_direct_passt]
      true
    else
      false
    end
  end

#  def create
#      self.debug("create: not purging puppet controlled direct rule #{fwr[:name]}")
#  end

  def destroy
      self.debug("destroy: not purging puppet controlled direct rule")
  end

  def get_direct_rules
    args=['--permanent', '--direct', '--get-all-rules'].join(' ')
    output = %x{ /usr/bin/firewall-cmd #{args} 2>&1}
    return output.split(/\n/)
  end

  def get_direct_chains
    args=['--permanent', '--direct', '--get-chains'].join(' ')
    output = %x{ /usr/bin/firewall-cmd #{args} 2>&1}
    return output.split(/\n/)
  end

  def get_direct_passt
    args=['--permanent', '--direct', '--get-passthroughs'].join(' ')
    output = %x{ /usr/bin/firewall-cmd #{args} 2>&1}
    return output.split(/\n/)
  end

end
