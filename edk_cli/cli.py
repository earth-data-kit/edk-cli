import click
import os
import importlib.resources as ir

@click.group()
def edk():
    pass


@edk.command()
@click.option(
    "--aws_config_dir",
    prompt="AWS config directory.",
    default=os.path.expanduser("~/.aws"),
    required=False,
    type=click.Path(exists=False, file_okay=False, dir_okay=True),
    help="The directory where AWS config and credentials are stored.",
)
@click.option(
    "--google_application_credentials",
    prompt="Google Application Credentials.",
    default="/app/workspace/google_application_credentials.json",
    type=click.Path(exists=False, file_okay=True, dir_okay=False),
    callback=lambda _, __, value: value if value else None,
    help="The path to the Google Application Credentials as within the container.",
)
@click.option(
    "--workspace_dir",
    prompt="Workspace directory (Required)",
    default="./workspace",
    required=True,
    type=click.Path(file_okay=False, dir_okay=True),
    callback=lambda _, __, value: value if value else None,
    help="The directory where your code is.",
)
@click.option(
    "--data_dir",
    prompt="Data directory (Required)",
    default="./data",
    required=True,
    type=click.Path(file_okay=False, dir_okay=True),
    callback=lambda _, __, value: value if value else None,
    help="The directory where all the data and mosaics will be stored.",
)
def configure(aws_config_dir, google_application_credentials, workspace_dir, data_dir):
    """Helps user create .env."""

    # Create directories if they don't exist
    os.makedirs(workspace_dir, exist_ok=True)
    os.makedirs(data_dir, exist_ok=True)

    # Convert relative paths to absolute paths for consistency
    workspace_dir = os.path.abspath(workspace_dir)
    data_dir = os.path.abspath(data_dir)

    with open("./.env", "w") as f:
        f.write(f"AWS_CONFIG_DIR={aws_config_dir}\n")
        f.write(f"GOOGLE_APPLICATION_CREDENTIALS={google_application_credentials}\n")
        f.write(f"WORKSPACE_DIR={workspace_dir}\n")
        f.write(f"DATA_DIR={data_dir}\n")

    click.secho(".env file created successfully.\n", fg="green")
    click.secho(f"Created directories:\n  - {workspace_dir}\n  - {data_dir}\n", fg="green")
    click.secho("You can find more options about environment variables at https://earth-data-kit.github.io/getting-started.html#environment-configuration", fg="green")


@edk.command()
def run():
    """Builds and run the edk container."""
    
    if not os.path.exists("./.env"):
        raise FileNotFoundError(".env file not found. Please run 'edk configure' first.")
    
    click.secho(f"Building edk container...\n", fg="green")
    dockerfile_path = ir.files("edk_cli") / "scripts" / "Dockerfile"
    script = ir.files("edk_cli") / "scripts" / "build.sh"
    command = f"bash {script} {dockerfile_path}"
    os.system(command)


    click.secho(f"Running edk container...\n", fg="green")
    script = ir.files("edk_cli") / "scripts" / "run.sh"
    command = f"bash {script}"
    os.system(command)

@edk.command()
def ssh():
    """SSH into the edk container."""
    click.secho(f"SSH into edk container...\n", fg="green")
    script = ir.files("edk_cli") / "scripts" / "exec-edk.sh"
    command = f"bash {script}"
    os.system(command)

@edk.command()
def notebook():
    """Starts a jupyter notebook."""
    click.secho(f"Starting a jupyter notebook...\n", fg="green")
    script = ir.files("edk_cli") / "scripts" / "start-notebook.sh"
    command = f"bash {script}"
    os.system(command)