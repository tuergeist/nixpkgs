{ lib
, asyncssh
, buildPythonPackage
, dulwich
, dvc-http
, dvc-objects
, fetchFromGitHub
, fsspec
, funcy
, gitpython
, pathspec
, pygit2
, pygtrie
, pythonOlder
, setuptools
, setuptools-scm
, shortuuid
}:

buildPythonPackage rec {
  pname = "scmrepo";
  version = "2.0.3";
  format = "pyproject";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "iterative";
    repo = pname;
    rev = "refs/tags/${version}";
    hash = "sha256-P+Mbf8adSvQPkUgnTSPrqzvHc6lR0ns2mJ0/x9YGPKs=";
  };

  nativeBuildInputs = [
    setuptools
    setuptools-scm
  ];

  propagatedBuildInputs = [
    asyncssh
    dulwich
    dvc-http
    dvc-objects
    fsspec
    funcy
    gitpython
    pathspec
    pygit2
    pygtrie
    shortuuid
  ];

  # Requires a running Docker instance
  doCheck = false;

  pythonImportsCheck = [
    "scmrepo"
  ];

  meta = with lib; {
    description = "SCM wrapper and fsspec filesystem";
    homepage = "https://github.com/iterative/scmrepo";
    changelog = "https://github.com/iterative/scmrepo/releases/tag/${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}
