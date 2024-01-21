from flask import Blueprint, send_from_directory

maocao_logo_bp = Blueprint('maocao_logo_bp', __name__)

@maocao_logo_bp.route('/maocao-logo')
def maocao_logo():
    return send_from_directory('static', 'images/maocao-logo-1.png')
