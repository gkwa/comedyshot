from subprocess import PIPE, STDOUT, Popen


def test_ensure_php_composer_is_installed():
    cmd = "composer --version"
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    output = p.stdout.read().decode()
    assert "Composer version " in output
    assert "Available commands:" in output


def test_openssh_service_is_running():
    cmd = "lsof -P -N -i :22"
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    output = p.stdout.read().decode()
    assert "TCP *:22" in output


def test_sls_service_is_running():
    cmd = "systemctl status sls"
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    output = p.stdout.read().decode()
    assert "Active: active (running)" in output


def test_mysql_is_running():
    cmd = "systemctl status mysql"
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    output = p.stdout.read().decode()
    assert "Active: active (running)" in output


def test_node_exporter_is_running():
    cmd = "systemctl status node_exporter"
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    output = p.stdout.read().decode()
    assert "Active: active (running)" in output


def test_python_version_is_as_expected():
    cmd = "python3 --version"
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    output = p.stdout.read().decode()
    assert "Python 3.8" in output


def test_php_version_is_as_expected():
    cmd = "php --version"
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    output = p.stdout.read().decode()
    assert "PHP 5.6" in output


def test_can_connnect_to_mysql():
    cmd = "mysql --execute 'SHOW DATABASES'"
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    output = p.stdout.read().decode()
    assert "information_schema" in output


def test_ensure_nodejs_is_installed():
    cmd = "/bin/node -v"
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    output = p.stdout.read().decode()
    assert "v18" in output


def test_apache_is_running():
    cmd = "systemctl status apache2"
    p = Popen(cmd, shell=True, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
    output = p.stdout.read().decode()
    assert "Active: active (running)" in output

    cmd = "systemctl status apache2"

    process = Popen(cmd.split(" "), stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()

    assert stderr.decode() == ""
    assert "Active: active (running)" in stdout.decode()

    cmd = "ss -tlpn"

    process = Popen(cmd.split(" "), stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()

    assert stderr.decode() == ""
    assert ":80" in stdout.decode()
