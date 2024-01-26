{ config, lib, pkgs, ... }:

{
  services.pcscd.enable = true;

  # programs.firefox = {
  #   enable = true;
  #   # nativeMessagingHosts.euwebid = true;
  #   policies.SecurityDevices.p11-kit-proxy =
  #     "${pkgs.p11-kit}/lib/p11-kit-proxy.so";
  # };
  # Tell p11-kit to load/proxy opensc-pkcs11.so, providing all available slots
  # (PIN1 for authentication/decryption, PIN2 for signing).
  environment.etc."pkcs11/modules/opensc-pkcs11".text = ''
    module: ${pkgs.opensc}/lib/opensc-pkcs11.so
  '';
  environment.etc."pkcs11/modules/pki-pkcs11".text = ''
    module: /home/nsa/smartcard/libcvP11.so
    critical: yes
  '';
  environment.systemPackages = with pkgs; [
    # Wrapper script to tell to Chrome/Chromium to use p11-kit-proxy to load
    # security devices, so they can be used for TLS client auth.
    # Each user needs to run this themselves, it does not work on a system level
    # due to a bug in Chromium:
    #
    # https://bugs.chromium.org/p/chromium/issues/detail?id=16387
    nssTools
    p11-kit
    (pkgs.writeShellScriptBin "setup-browser-eid" ''
      NSSDB="''${HOME}/.pki/nssdb"
      mkdir -p ''${NSSDB}

      ${pkgs.nssTools}/bin/modutil -force -dbdir sql:$NSSDB -add p11-kit-proxy \
        -libfile ${pkgs.p11-kit}/lib/p11-kit-proxy.so
    '')
  ];

}
