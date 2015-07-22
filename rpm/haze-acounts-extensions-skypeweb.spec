Name:       haze-accounts-extensions-skypeweb

Summary:    Extensions plugins for Telepathy Haze library Skypweb
Version:    0.1
Release:    1
Group:      System/Application
License:    GPL3
Source0:    https://github.com/Thaodan/haze-acounts-extensions-skypeweb/archive/v%{Version}.tar.gz
Requires:   libpurple
Requires:   telepathy-haze
Requires:   jolla-settings-accounts >= 0.2.27
Requires:   purple-skypeweb
BuildArch:  noarch

%description
Extensions plugins for Telepathy Haze library Skypweb

%prep
%setup -q

# >> setup
# << setup

%build
# >> build pre
# << build pre

# >> build post
# << build post

%install
rm -rf %{buildroot}

mkdir -p %{buildroot}%{_datadir}/haze-accounts-extensions/icons

mkdir -p %{buildroot}%{_datadir}/accounts
mkdir -p %{buildroot}%{_datadir}/accounts/providers
mkdir -p %{buildroot}%{_datadir}/accounts/services
mkdir -p %{buildroot}%{_datadir}/accounts/ui

install -m 644 icons/* %{buildroot}%{_datadir}/haze-accounts-extensions/icons

install -m 644 src/skypeweb.provider %{buildroot}%{_datadir}/accounts/providers
install -m 644 src/skypeweb.service %{buildroot}%{_datadir}/accounts/services
install -m 644 src/skypeweb.qml %{buildroot}%{_datadir}/accounts/ui
install -m 644 src/skypeweb-settings.qml %{buildroot}%{_datadir}/accounts/ui
install -m 644 src/skypeweb-update.qml %{buildroot}%{_datadir}/accounts/ui
install -m 644 src/SkypeCommon.qml %{buildroot}%{_datadir}/accounts/ui
install -m 644 src/SkypeSettingsDisplay.qml %{buildroot}%{_datadir}/accounts/ui

# >> install pre
# << install pre

# >> install post
# << install post

%files
%defattr(-,root,root,-)
%{_datadir}/accounts/providers/*
%{_datadir}/accounts/services/*
%{_datadir}/accounts/ui/*
%{_datadir}/haze-accounts-extensions/icons/*

%clean
rm -rf %{buildroot}
