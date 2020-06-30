require 'pathname'

Puppet::Type.newtype(:dsc_spincomingemailsettings) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'
  require Pathname.new(__FILE__).dirname + '../../puppet_x/puppetlabs/dsc_type_helpers'


  @doc = %q{
    The DSC SPIncomingEmailSettings resource type.
    Automatically generated from
    'SharePointDsc/DSCResources/MSFT_SPIncomingEmailSettings/MSFT_SPIncomingEmailSettings.schema.mof'

    To learn more about PowerShell Desired State Configuration, please
    visit https://technet.microsoft.com/en-us/library/dn249912.aspx.

    For more information about built-in DSC Resources, please visit
    https://technet.microsoft.com/en-us/library/dn249921.aspx.

    For more information about xDsc Resources, please visit
    https://github.com/PowerShell/DscResources.
  }

  validate do
      fail('dsc_issingleinstance is a required attribute') if self[:dsc_issingleinstance].nil?
    end

  def dscmeta_resource_friendly_name; 'SPIncomingEmailSettings' end
  def dscmeta_resource_name; 'MSFT_SPIncomingEmailSettings' end
  def dscmeta_module_name; 'SharePointDsc' end
  def dscmeta_module_version; '3.2.0.0' end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    newvalue(:absent)  { provider.destroy }
    defaultto { :present }
  end

  # Name:         PsDscRunAsCredential
  # Type:         MSFT_Credential
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_psdscrunascredential) do
    def mof_type; 'MSFT_Credential' end
    def mof_is_embedded?; true end
    desc "PsDscRunAsCredential"
    validate do |value|
      unless value.kind_of?(Hash)
        fail("Invalid value '#{value}'. Should be a hash")
      end
      PuppetX::Dsc::TypeHelpers.validate_MSFT_Credential("Credential", value)
    end
    munge do |value|
      PuppetX::Dsc::TypeHelpers.munge_sensitive_hash!(value)
    end
  end

  # Name:         IsSingleInstance
  # Type:         string
  # IsMandatory:  True
  # Values:       ["Yes"]
  newparam(:dsc_issingleinstance) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "IsSingleInstance - Specifies the resource is a single instance, the value must be 'Yes' Valid values are Yes."
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Yes', 'yes'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Yes")
      end
    end
  end

  # Name:         Ensure
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Present", "Absent"]
  newparam(:dsc_ensure) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Ensure - Present ensures Incoming Email is enabled. Absent disables incoming email Valid values are Present, Absent."
    validate do |value|
      resource[:ensure] = value.downcase
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Present', 'present', 'Absent', 'absent'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Present, Absent")
      end
    end
  end

  # Name:         UseAutomaticSettings
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_useautomaticsettings) do
    def mof_type; 'boolean' end
    def mof_is_embedded?; false end
    desc "UseAutomaticSettings - Automatic Settings enables a local SMTP service on the SharePoint server. Set to False to use an external drop folder"
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      PuppetX::Dsc::TypeHelpers.munge_boolean(value.to_s)
    end
  end

  # Name:         UseDirectoryManagementService
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Yes", "No", "Remote"]
  newparam(:dsc_usedirectorymanagementservice) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "UseDirectoryManagementService - Set to Yes, the service supports the creation and management of e-mail distribution groups from SharePoint Sites, and creates mail contacts mail enabled SharePoint lists. Set to Remote to use a remote SharePoint Directory Management Web Service Valid values are Yes, No, Remote."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Yes', 'yes', 'No', 'no', 'Remote', 'remote'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Yes, No, Remote")
      end
    end
  end

  # Name:         RemoteDirectoryManagementURL
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_remotedirectorymanagementurl) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "RemoteDirectoryManagementURL - URL to the remote SharePoint Directory Management Web Service"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         ServerAddress
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_serveraddress) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "ServerAddress - SMTP Server Address when Directory Managment Service mode is used"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DLsRequireAuthenticatedSenders
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_dlsrequireauthenticatedsenders) do
    def mof_type; 'boolean' end
    def mof_is_embedded?; false end
    desc "DLsRequireAuthenticatedSenders - SharePoint Distribution lists accept from authenticated senders only"
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      PuppetX::Dsc::TypeHelpers.munge_boolean(value.to_s)
    end
  end

  # Name:         DistributionGroupsEnabled
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_distributiongroupsenabled) do
    def mof_type; 'boolean' end
    def mof_is_embedded?; false end
    desc "DistributionGroupsEnabled - Allow creation of distribution groups from within SharePoint"
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      PuppetX::Dsc::TypeHelpers.munge_boolean(value.to_s)
    end
  end

  # Name:         ServerDisplayAddress
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_serverdisplayaddress) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "ServerDisplayAddress - Email server display address 'mylist@example.com'"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DropFolder
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_dropfolder) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "DropFolder - Path to email drop folder if not using Automatic Settings"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         InstallAccount
  # Type:         MSFT_Credential
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_installaccount) do
    def mof_type; 'MSFT_Credential' end
    def mof_is_embedded?; true end
    desc "InstallAccount - POWERSHELL 4 ONLY: The account to run this resource as, use PsDscRunAsCredential if using PowerShell 5"
    validate do |value|
      unless value.kind_of?(Hash)
        fail("Invalid value '#{value}'. Should be a hash")
      end
      PuppetX::Dsc::TypeHelpers.validate_MSFT_Credential("InstallAccount", value)
    end
    munge do |value|
      PuppetX::Dsc::TypeHelpers.munge_sensitive_hash!(value)
    end
  end


  def builddepends
    pending_relations = super()
    PuppetX::Dsc::TypeHelpers.ensure_reboot_relationship(self, pending_relations)
  end
end

Puppet::Type.type(:dsc_spincomingemailsettings).provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
  confine :true => (Gem::Version.new(Facter.value(:powershell_version)) >= Gem::Version.new('5.0.10586.117'))
  defaultfor :operatingsystem => :windows

  mk_resource_methods
end
